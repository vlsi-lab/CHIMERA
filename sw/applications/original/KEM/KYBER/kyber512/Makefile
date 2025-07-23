# ****************************************************************************
#
# Auth: Alessandra Dolmeta - Politecnico di Torino
# Date: June 2024
# ****************************************************************************

# Compiled application has the same name of its folder
APPLI   = $(shell basename $(CURDIR))
SOURCES = src/kem.c src/indcpa.c src/polyvec.c src/symmetric-shake.c src/poly.c src/ntt.c src/cbd.c src/reduce.c src/verify.c src/fips202.c src/randombytes.c
SRC     = $(SOURCES) \
          main.c

INC         = -I include/
EXTRA_CFLAGS = -g -O2

# Conditional flags based on the defined parameters
ifdef NTESTS
EXTRA_CFLAGS += -DNTESTS=$(NTESTS)
endif

# Part to test
TEST_KEY ?= 1
TEST_ENC ?= 1
TEST_DEC ?= 1

# Add the test parameters to EXTRA_CFLAGS
EXTRA_CFLAGS += -DTEST_KEY=$(TEST_KEY) -DTEST_ENC=$(TEST_ENC) -DTEST_DEC=$(TEST_DEC)
EXTRA_CFLAGS += -DTEST_VECT_INCLUDE="\"test_vectors_512.h\""

# Debug print statements
$(info APPLI: $(APPLI))
$(info EXTRA_CFLAGS: $(EXTRA_CFLAGS))
$(info PRINT_VECT: $(PRINT_VECT))
# Compiler
CC = gcc

# Targets
all: $(APPLI)

$(APPLI): $(SRC)
	$(CC) $(SRC) $(INC) $(EXTRA_CFLAGS) -o $(APPLI)

clean:
	rm -f $(APPLI)

.PHONY: all clean
