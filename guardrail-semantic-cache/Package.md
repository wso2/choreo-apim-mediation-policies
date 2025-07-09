# Semantic Caching

## Overview

This policy leverages semantic caching to optimize API performance. When a request is received, the system checks the vector store for a cached response that is semantically similar to the query. If a match is found, the cached response is returned immediately—reducing both latency and computational costs by avoiding unnecessary calls to the LLM backend.

## Usage
The following policy parameters are available. Mainly the configurations can be broken down into two main categories:

Embedding Provider Configurations
- `Header Name`: If AI model requires authentication via Authorization or API key header, specify its name here.
- `API Key`: API Key for the desired embedding provider
- `Embedding Provider`: AI provider format to use for embeddings API
- `Embedding Model Name`: Model name to execute.
- `Embedding Upstream URL`: Endpoint URL for the emedding generation

Vector DB Configurations
- `Dimentions`: The desired dimensionality for the vectors
- `Threshold`: The default similarity threshold for accepting semantic search results.
- `Vector Store`: Which vector database driver to use(Redis or Milvus)
- `Host`: A string representing the databse host.
- `Port`: An integer representing a port number between 0 and 65535, inclusive.
- `Database`: Name of the database need to be used
- `Username`: Username for the database user
- `Password`: Password for the provided database user

The policy should be applied to both request and response flow of the API resources.
