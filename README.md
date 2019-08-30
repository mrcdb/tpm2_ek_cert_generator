# TPM 2.0 simulator EK cert generator

This repository includes a script to generate an EK cert signed by a self-signed CA,
which is also generated as part of the script.

The EK cert is also written to the TPM 2.0 NVRAM in the index `0x1c00002` (reserved
index in TPM 2.0 specs) with platform authorization.

This allows to use the TPM 2.0 simulator in a remote attestation scheme that would require
the Verifier to validate the EK provided by the Attester.

This work is based uponthe script developed by [op-ct](https://gist.github.com/op-ct/e202fc911de22c018effdb3371e8335f) and extends it to fully automate EK certificate generation and loading in the TPM 2.0 simulator.

## Prerequisites

A running instance of [Microsoft TPM 2.0 simulator](https://github.com/microsoft/ms-tpm-20-ref) is required.

Moreover, [Intel TSS](https://github.com/tpm2-software/tpm2-tss) and [TPM CLI tools](https://github.com/tpm2-software/tpm2-tools) should be installed.

Although not mandatory, it is preferred to query the TPM 2.0 via the [TPM 2.0 Access Broker & Resource Management Daemon] (https://github.com/tpm2-software/tpm2-abrmd).

Finally, `openssl` should be installed. This script has been tested with version `1.1.1`.

## How to run

First, ensure that the TPM 2.0 simulator is working:

```
user@os:~$ tpm2_getrandom 4
0xED 0x07 0xBD 0xFB
```

Then, ensure that the parameters in the `./generate.ek.cert.sh` script are correct,
in particular:

```
readonly endorsment_auth='' # set to '-e $PASSWORD' if different from null
readonly owner_auth='' # set to '-o $PASSWORD' if different from null
```

Finally, just run the following command:

```
$ make
```

The EK certificate is available in the script root dir both in PEM and DER format
as `./tpm2_ekc.{pem|der}.crt`.

The CA certificate is available in the `./_tpm2__working_dir/tpm2_CA.crt` file
in PEM format.

## Cleanup

To remove all script-generate files, just run:

```
$ make clean
```
