#include <stdio.h>
#include <string.h>
#include "crypto_hash.h"

#ifdef PERF_CNT_CYCLES
    #include "core_v_mini_mcu.h"
    #include "csr.h"
#endif


#define CRYPTO_BYTES 32  // Assume the hash output size is 32 bytes

int main() {
    // Example input data
    const char* input = "\0";
    unsigned long long input_len = strlen(input);
    
    // Buffer to store the hash output
    unsigned char hash_output[CRYPTO_BYTES];
    
    // Golden result to compare with (the expected hash output)
    unsigned char golden_result[CRYPTO_BYTES] = { 0x7C, 0x10, 0xDF, 0xFD, 0x6B, 0xB0, 0x3B, 0xE2, 0x62, 0xD7, 0x2F, 0xBE, 0x1B, 0x0F, 0x53, 0x00, 0x13, 0xC6, 0xC4, 0xEA, 0xDA, 0xAB, 0xDE, 0x27, 0x8D, 0x6F, 0x29, 0xD5, 0x79, 0xE3, 0x90, 0x8D };


    #if PERF_CNT_CYCLES
        unsigned int cycles;
    #endif
    
    printf("Test started!\n");
    #ifdef PERF_CNT_CYCLES
        CSR_CLEAR_BITS(CSR_REG_MCOUNTINHIBIT, 0x1);
        CSR_WRITE(CSR_REG_MCYCLE, 0);
    #endif
    crypto_hash(hash_output, (const unsigned char*)input, input_len);
    #ifdef PERF_CNT_CYCLES
        CSR_READ(CSR_REG_MCYCLE, &cycles);
        printf("Number of clock cycles for test-1 : %d\n", cycles);
    #endif
    
    // Print the hash output
    //printf("Hash of input is:\n");
    //for (int i = 0; i < CRYPTO_BYTES; i++) {
    //    printf("%02x", hash_output[i]);
    //}
    //printf("\n");
    
    // Compare with the golden result
    if (memcmp(hash_output, golden_result, CRYPTO_BYTES) == 0) {
        printf("Hash matches the golden result!\n");
    } else {
        printf("Hash does NOT match the golden result.\n");
    }
    
    printf("Test: terminated\n");

    return 0;
}
