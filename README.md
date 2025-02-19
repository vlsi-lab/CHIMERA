# CHIMERA

## Branches

- main
  - 
- CR
  - 
- BRU
  - 

## Getting started

Once you have cloned the repository:
```
make mcu-gen
make x_heep-sync
make questasim-sim
```

Then, depending on the applications you want to run, you need to do:
```
make app-$(ACC)-LWC-ASCON-$(VERSION) SCHEME=LWC ALG=ASCON VERSION=$(VERSION)$ ACC=$(ACC)

make run-$(ACC)-LWC-ASCON-$(VERSION) SCHEME=LWC ALG=ASCON VERSION=$(VERSION)$ ACC=$(ACC)
```

With $(ACC) = original, optimized, and $(VERSION) = asconhashav12, asconhashv12, asconxofav12, asconxofv12, ascon128av12, ascon128v12, ascon80pqv12.


## All apps-available
This part summarized build and run commands for the different ASCON-version in the repository.

## Original

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

## Optimized
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


