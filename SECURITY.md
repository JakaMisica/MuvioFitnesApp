# Security Policy

## Supported Versions

This repository currently tracks the active public version of Muvio.

## Reporting a Vulnerability

Do not publish secrets, API keys, or exploit details in public issues.

If you find a security issue, contact the repository owner privately through GitHub.

## Secret Handling

The project intentionally excludes:

- Firebase configuration files
- Android keystores
- Signing passwords
- API keys
- Generated release artifacts

Use Dart defines, local ignored files, and GitHub secrets for private values.
