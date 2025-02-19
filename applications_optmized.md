# Build and Run Commands

This document organizes the build and run commands for the different cryptographic schemes, algorithms, and configurations in the repository.

## Optimzied

### 3. Lightweight Cryptography-APPS 

#### ASCON
##### ASCON Hash av12
```bash
make app-optimized-LWC-ASCON-asconhashav12 SCHEME=LWC ALG=ASCON VERSION=asconhashav12 ACC=optimized
make run-optimized-LWC-ASCON-asconhashav12 SCHEME=LWC ALG=ASCON VERSION=asconhashav12 ACC=optimized
```
##### ASCON Hash v12
```bash
make app-optimized-LWC-ASCON-asconhashv12 SCHEME=LWC ALG=ASCON VERSION=asconhashv12 ACC=optimized
make run-optimized-LWC-ASCON-asconhashv12 SCHEME=LWC ALG=ASCON VERSION=asconhashv12 ACC=optimized
```
##### ASCON XOF av12
```bash
make app-optimized-LWC-ASCON-asconxofav12 SCHEME=LWC ALG=ASCON VERSION=asconxofav12 ACC=optimized
make run-optimized-LWC-ASCON-asconxofav12 SCHEME=LWC ALG=ASCON VERSION=asconxofav12 ACC=optimized
```
##### ASCON XOF v12
```bash
make app-optimized-LWC-ASCON-asconxofv12 SCHEME=LWC ALG=ASCON VERSION=asconxofv12 ACC=optimized
make run-optimized-LWC-ASCON-asconxofv12 SCHEME=LWC ALG=ASCON VERSION=asconxofv12 ACC=optimized
```
##### ASCON 128 AEAD av12
```bash
make app-optimized-LWC-ASCON-ascon128av12 SCHEME=LWC ALG=ASCON VERSION=ascon128av12 ACC=optimized
make run-optimized-LWC-ASCON-ascon128av12 SCHEME=LWC ALG=ASCON VERSION=ascon128av12 ACC=optimized
```
##### ASCON 128 AEAD v12
```bash
make app-optimized-LWC-ASCON-ascon128v12 SCHEME=LWC ALG=ASCON VERSION=ascon128v12 ACC=optimized
make run-optimized-LWC-ASCON-ascon128v12 SCHEME=LWC ALG=ASCON VERSION=ascon128v12 ACC=optimized
```
##### ASCON 80 pqv12
```bash
make app-optimized-LWC-ASCON-ascon80pqv12 SCHEME=LWC ALG=ASCON VERSION=ascon80pqv12 ACC=optimized
make run-optimized-LWC-ASCON-ascon80pqv12 SCHEME=LWC ALG=ASCON VERSION=ascon80pqv12 ACC=optimized
```