# Build and Run Commands

This document organizes the build and run commands for the different cryptographic schemes, algorithms, and configurations in the repository.

## Original

### Lightweight Cryptography-APPS 

#### ASCON
##### ASCON Hash av12
```bash
make app-original-LWC-ASCON-asconhashav12 SCHEME=LWC ALG=ASCON VERSION=asconhashav12 ACC=original
make run-original-LWC-ASCON-asconhashav12 SCHEME=LWC ALG=ASCON VERSION=asconhashav12 ACC=original
```
##### ASCON Hash v12
```bash
make app-original-LWC-ASCON-asconhashv12 SCHEME=LWC ALG=ASCON VERSION=asconhashv12 ACC=original
make run-original-LWC-ASCON-asconhashv12 SCHEME=LWC ALG=ASCON VERSION=asconhashv12 ACC=original
```
##### ASCON XOF av12
```bash
make app-original-LWC-ASCON-asconxofav12 SCHEME=LWC ALG=ASCON VERSION=asconxofav12 ACC=original
make run-original-LWC-ASCON-asconxofav12 SCHEME=LWC ALG=ASCON VERSION=asconxofav12 ACC=original
```
##### ASCON XOF v12
```bash
make app-original-LWC-ASCON-asconxofv12 SCHEME=LWC ALG=ASCON VERSION=asconxofv12 ACC=original
make run-original-LWC-ASCON-asconxofv12 SCHEME=LWC ALG=ASCON VERSION=asconxofv12 ACC=original
```
##### ASCON 128 AEAD av12
```bash
make app-original-LWC-ASCON-ascon128av12 SCHEME=LWC ALG=ASCON VERSION=ascon128av12 ACC=original
make run-original-LWC-ASCON-ascon128av12 SCHEME=LWC ALG=ASCON VERSION=ascon128av12 ACC=original
```
##### ASCON 128 AEAD v12
```bash
make app-original-LWC-ASCON-ascon128v12 SCHEME=LWC ALG=ASCON VERSION=ascon128v12 ACC=original
make run-original-LWC-ASCON-ascon128v12 SCHEME=LWC ALG=ASCON VERSION=ascon128v12 ACC=original
```
##### ASCON 80 pqv12
```bash
make app-original-LWC-ASCON-ascon80pqv12 SCHEME=LWC ALG=ASCON VERSION=ascon80pqv12 ACC=original
make run-original-LWC-ASCON-ascon80pqv12 SCHEME=LWC ALG=ASCON VERSION=ascon80pqv12 ACC=original
```
