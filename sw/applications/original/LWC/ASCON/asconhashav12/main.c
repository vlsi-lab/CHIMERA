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
    unsigned char golden_result[CRYPTO_BYTES] = {
        0xae, 0xcd, 0x02, 0x70, 0x26, 0xd0, 0x67, 0x5f,
        0x9d, 0xe7, 0xa8, 0xad, 0x8c, 0xcf, 0x51, 0x2d,
        0xb6, 0x4b, 0x1e, 0xdc, 0xf0, 0xb2, 0x0c, 0x38,
        0x8a, 0x0c, 0x7c, 0xc6, 0x17, 0xaa, 0xa2, 0xc4
    };

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
