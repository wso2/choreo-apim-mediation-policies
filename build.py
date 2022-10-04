# Copyright (c) 2022 WSO2 LLC (http://www.wso2.org) All Rights Reserved.
#
# WSO2 LLC licenses this file to you under the Apache License,
# Version 2.0 (the "License"); you may not use this file except
# in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

import json
import os
import sys
import enum

import toml
import semantic_version

from git import Repo
from github import Github

packages = json.load(open("./packages.json"))


def build():
    failed_projects = []

    for pkg in packages:
        bal_toml = toml.load(os.path.join(pkg['name'], 'Ballerina.toml'))
        toml_version = semantic_version.Version(bal_toml['package']['version'])
        pkg_json_version = semantic_version.Version(pkg['version'])

        if pkg_json_version >= toml_version:
            print(pkg['name'], 'is already in the latest version')
            continue

        print(f'Building \'{pkg["name"]}\'')
        exit_code = os.system(f'bal build {pkg["name"]}')

        if exit_code != 0:
            print(f'Failed to build {pkg["name"]}')
            failed_projects.append(pkg['name'])

    if failed_projects:
        raise ValueError(f'Failed to build the following projects: {failed_projects}')


def rc_build():
    local_repo = Repo('.')
    gh_repo = Github(os.environ['GITHUB_TOKEN']).get_repo("wso2/choreo-apim-mediation-policies")
    failed_projects = []

    for pkg in packages:
        bal_toml = toml.load(os.path.join(pkg['name'], 'Ballerina.toml'))
        toml_version = semantic_version.Version(bal_toml['package']['version'])
        pkg_json_version = semantic_version.Version(pkg['version'])

        # Only do a release if the Ballerina.toml specifies a newer version than the corresponding version in packages.json
        if pkg_json_version >= toml_version:
            print(pkg['name'], 'is already in the latest version')
            continue

        pkg['version'] = bal_toml['package']['version']
        exit_code = build_and_push_to_central(pkg['name'], bal_toml)

        if exit_code != 0:
            failed_projects.append(pkg['name'])
            continue

        if os.environ.get('BALLERINA_PROD_CENTRAL', 'false').casefold() == 'false':
            continue

        # Create and push Git tag
        version_tag = f'{pkg["name"][10:]}-v{bal_toml["package"]["version"]}' # 10 = len('mediation')
        local_repo.git.tag(version_tag)
        local_repo.git.push('origin', version_tag)

        # Create a GitHub release with the bala file attached
        gh_release = gh_repo.create_git_release(version_tag, f'{pkg["name"]} v{pkg["version"]} released!', '')
        gh_release.upload_asset(get_bala_path(pkg['name'], bal_toml))

    if os.environ.get('BALLERINA_PROD_CENTRAL', 'false').casefold() == 'false':
        return

    # Update and commit the changes in the versions of the packages
    json.dump(packages, open("packages.json", "w"), indent=4)

    if local_repo.git.diff('packages.json'):
        local_repo.git.add('packages.json')
        local_repo.git.commit('-m', '[automated] Update packages.json')
        local_repo.git.push('-f', 'origin', local_repo.git.branch('--show-current'))

    if failed_projects:
        raise ValueError(f'Failed to build the following projects: {failed_projects}')


#### Utils

def build_and_push_to_central(project_name, bal_toml):
    print(f'Building \'{project_name}\'')
    exit_code = os.system(f'bal pack {project_name}')

    if exit_code != 0:
        print(f'Failed to build {project_name}')
        return exit_code

    if os.environ.get('BALLERINA_PROD_CENTRAL', 'false').casefold() == 'true':
        return 0

    # TODO: Remove --repository=local
    exit_code = os.system(f'bal push --repository=local {get_bala_path(project_name, bal_toml)}')

    # Not incrementing the exit_code_aggragate for this case since even if this fails, this is something we can
    # easily re-try manually later on since the bala file gets attached as a release artifact.
    if exit_code != 0:
        print(f'Failed to push {project_name} to Central')

    return 0


def get_bala_path(project_name, bal_toml):
    return os.path.join(project_name, 'target', 'bala', derive_bala_name(bal_toml))


def derive_bala_name(bal_toml):
    org = bal_toml['package']['org']
    pkg = bal_toml['package']['name']
    ver = bal_toml['package']['version']
    return f'{org}-{pkg}-any-{ver}.bala'


if len(sys.argv) < 2:
    raise ValueError('Missing build kind argument')

if sys.argv[1] == 'build':
    build()
elif sys.argv[1] == 'release':
    rc_build()
else:
    raise ValueError(f'Unrecognized build kind: {sys.argv[1]}')
