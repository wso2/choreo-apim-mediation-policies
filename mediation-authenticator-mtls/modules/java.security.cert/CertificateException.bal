// Ballerina error type for `java.security.cert.CertificateException`.

public const CERTIFICATEEXCEPTION = "CertificateException";

type CertificateExceptionData record {
    string message;
};

public type CertificateException distinct error<CertificateExceptionData>;

