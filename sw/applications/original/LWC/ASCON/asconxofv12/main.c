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
    unsigned char golden_result[CRYPTO_BYTES] = { 0x5D, 0x4C, 0xBD, 0xE6, 0x35, 0x0E, 0xA4, 0xC1, 0x74, 0xBD, 0x65, 0xB5, 0xB3, 0x32, 0xF8, 0x40, 0x8F, 0x99, 0x74, 0x0B, 0x81, 0xAA, 0x02, 0x73, 0x5E, 0xAE, 0xFB, 0xCF, 0x0B, 0xA0, 0x33, 0x9E };


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
