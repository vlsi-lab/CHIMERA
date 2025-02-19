#ifndef ROUND_H_
#define ROUND_H_

#include "ascon.h"
#include "printstate.h"

static inline uint64_t ROR(uint64_t x, int n) {
  return (x << (64 - n)) | (x >> n);
}

static inline void ror32_asm1(uint32_t a, uint32_t b, unsigned int offset, uint32_t *result1, uint32_t *result2) {
    
    asm volatile (
        ".insn r 0x6b, 0x01, 0x0, %[rd1],  %[rs2], %[rs1], %[i]\n\t"
        ".insn r 0x6b, 0x01, 0x1, %[rd2], x0, x0, x0\n\t"
        : [rd1] "=r" (*result1), [rd2] "=r" (*result2)
        : [rs1] "r" (a), [rs2] "r" (b), [i] "r" (offset)
        : "memory");
}

static inline void ror32_asm2(uint32_t a, uint32_t b, unsigned int offset, uint32_t *result1, uint32_t *result2) {
    
    asm volatile (
        ".insn r 0x6b, 0x01, 0x2, %[rd1],  %[rs2], %[rs1], %[i]\n\t"
        ".insn r 0x6b, 0x01, 0x1, %[rd2], x0, x0, x0\n\t"
        : [rd1] "=r" (*result1), [rd2] "=r" (*result2)
        : [rs1] "r" (a), [rs2] "r" (b), [i] "r" (offset)
        : "memory");
}

static inline void ror32_asm3(uint32_t a, uint32_t b, unsigned int offset, uint32_t *result1, uint32_t *result2) {
    
    asm volatile (
        ".insn r 0x6b, 0x01, 0x3, %[rd1],  %[rs2], %[rs1], %[i]\n\t"
        ".insn r 0x6b, 0x01, 0x1, %[rd2], x0, x0, x0\n\t"
        : [rd1] "=r" (*result1), [rd2] "=r" (*result2)
        : [rs1] "r" (a), [rs2] "r" (b), [i] "r" (offset)
        : "memory");
}


static inline void ror32_asm4(uint32_t a, uint32_t b, unsigned int offset, uint32_t *result1, uint32_t *result2) {
    
    asm volatile (
        ".insn r 0x6b, 0x02, 0x0, %[rd1],  %[rs2], %[rs1], %[i]\n\t"
        ".insn r 0x6b, 0x01, 0x1, %[rd2], x0, x0, x0\n\t"
        : [rd1] "=r" (*result1), [rd2] "=r" (*result2)
        : [rs1] "r" (a), [rs2] "r" (b), [i] "r" (offset)
        : "memory");
}

static inline void ror32_asm5(uint32_t a, uint32_t b, unsigned int offset, uint32_t *result1, uint32_t *result2) {
    
    asm volatile (
        ".insn r 0x6b, 0x02, 0x1, %[rd1],  %[rs2], %[rs1], %[i]\n\t"
        ".insn r 0x6b, 0x01, 0x1, %[rd2], x0, x0, x0\n\t"
        : [rd1] "=r" (*result1), [rd2] "=r" (*result2)
        : [rs1] "r" (a), [rs2] "r" (b), [i] "r" (offset)
        : "memory");
}


static inline void ROUND(state_t* s, uint8_t C) {
  // Split 64-bit registers into 32-bit parts
  uint64_t x0, x1, x2, x3, x4;
  uint32_t x0_high = s->x0 >> 32, x0_low = s->x0 & 0xFFFFFFFF;
  uint32_t x1_high = s->x1 >> 32, x1_low = s->x1 & 0xFFFFFFFF;
  uint32_t x2_high = s->x2 >> 32, x2_low = s->x2 & 0xFFFFFFFF;
  uint32_t x3_high = s->x3 >> 32, x3_low = s->x3 & 0xFFFFFFFF;
  uint32_t x4_high = s->x4 >> 32, x4_low = s->x4 & 0xFFFFFFFF;

  uint32_t t0_high, t0_low, t1_high, t1_low, t2_high, t2_low;
  uint32_t t3_high, t3_low, t4_high, t4_low;

  // Addition of round constant
  x2_low ^= C;

  // Substitution layer
  x0_high ^= x4_high;
  x4_high ^= x3_high;
  x0_low ^= x4_low;
  x4_low ^= x3_low;
  x2_high ^= x1_high;
  x2_low ^= x1_low;

  //t0_high = x0_high ^ (~x1_high & x2_high);
  //t0_low = x0_low ^ (~x1_low & x2_low);
  asm volatile(
      "not t1, %2\n\t"         // t1 = ~x1_high
      "and t1, t1, %3\n\t"     // t1 = (~x1_high & x2_high)
      "xor %0, %4, t1\n\t"     // t0_high = x0_high ^ t1
      "not t1, %5\n\t"         // t1 = ~x1_low
      "and t1, t1, %6\n\t"     // t1 = (~x1_low & x2_low)
      "xor %1, %7, t1\n\t"     // t0_low = x0_low ^ t1
      : "=r" (t0_high), "=r" (t0_low)  // Outputs
      : "r" (x1_high), "r" (x2_high), "r" (x0_high), // Inputs for t0_high
        "r" (x1_low), "r" (x2_low), "r" (x0_low)     // Inputs for t0_low
      : "t1"                           // Clobbered register
  );

  //t1_high = x1_high ^ (~x2_high & x3_high);
  //t1_low = x1_low ^ (~x2_low & x3_low);
  asm volatile(
    "not t1, %2\n\t"         // t1 = ~x1_high
    "and t1, t1, %3\n\t"     // t1 = (~x1_high & x2_high)
    "xor %0, %4, t1\n\t"     // t0_high = x0_high ^ t1
    "not t1, %5\n\t"         // t1 = ~x1_low
    "and t1, t1, %6\n\t"     // t1 = (~x1_low & x2_low)
    "xor %1, %7, t1\n\t"     // t0_low = x0_low ^ t1
    : "=r" (t1_high), "=r" (t1_low)  // Outputs
    : "r" (x2_high), "r" (x3_high), "r" (x1_high), // Inputs for t0_high
      "r" (x2_low), "r" (x3_low), "r" (x1_low)     // Inputs for t0_low
    : "t1"                           // Clobbered register
  );

  //t2_high = x2_high ^ (~x3_high & x4_high);
  //t2_low = x2_low ^ (~x3_low & x4_low);
  
  asm volatile(
    "not t1, %2\n\t"         
    "and t1, t1, %3\n\t"     
    "xor %0, %4, t1\n\t"     
    "not t1, %5\n\t"         
    "and t1, t1, %6\n\t"     
    "xor %1, %7, t1\n\t"     
    : "=r" (t2_high), "=r" (t2_low)  // Outputs
    : "r" (x3_high), "r" (x4_high), "r" (x2_high), // Inputs for t0_high
      "r" (x3_low), "r" (x4_low), "r" (x2_low)     // Inputs for t0_low
    : "t1"                           // Clobbered register
  );

  //t3_high = x3_high ^ (~x4_high & x0_high);
  //t3_low = x3_low ^ (~x4_low & x0_low);

  asm volatile(
    "not t1, %2\n\t"         
    "and t1, t1, %3\n\t"     
    "xor %0, %4, t1\n\t"     
    "not t1, %5\n\t"         
    "and t1, t1, %6\n\t"     
    "xor %1, %7, t1\n\t"     
    : "=r" (t3_high), "=r" (t3_low)  // Outputs
    : "r" (x4_high), "r" (x0_high), "r" (x3_high), // Inputs for t0_high
      "r" (x4_low), "r" (x0_low), "r" (x3_low)     // Inputs for t0_low
    : "t1"                           // Clobbered register
  );

  //t4_high = x4_high ^ (~x0_high & x1_high);
  //t4_low = x4_low ^ (~x0_low & x1_low);

  asm volatile(
    "not t1, %2\n\t"         
    "and t1, t1, %3\n\t"     
    "xor %0, %4, t1\n\t"     
    "not t1, %5\n\t"         
    "and t1, t1, %6\n\t"     
    "xor %1, %7, t1\n\t"     
    : "=r" (t4_high), "=r" (t4_low)  // Outputs
    : "r" (x0_high), "r" (x1_high), "r" (x4_high), // Inputs for t0_high
      "r" (x0_low), "r" (x1_low), "r" (x4_low)     // Inputs for t0_low
    : "t1"                           // Clobbered register
  );
 
  
  // End of Keccak S-box
  t1_high = t1_high ^ t0_high;
  t1_low  = t1_low  ^ t0_low;
  t0_high = t0_high ^ t4_high;
  t0_low  = t0_low  ^ t4_low;
  t3_high = t3_high ^ t2_high;
  t3_low  = t3_low  ^ t2_low;
  t2_high = ~t2_high;
  t2_low = ~t2_low;


  ror32_asm1(t0_high, t0_low, 4892, &x0_high, &x0_low);
  ror32_asm2(t1_high, t1_low, 15655, &x1_high, &x1_low);
  ror32_asm3(t2_high, t2_low, 262, &x2_high, &x2_low);
  ror32_asm4(t3_high, t3_low, 2577, &x3_high, &x3_low);
  ror32_asm5(t4_high, t4_low, 1833, &x4_high, &x4_low);


  // Recombine 32-bit parts into 64-bit registers
  s->x0 = ((uint64_t)x0_high << 32) | x0_low;
  s->x1 = ((uint64_t)x1_high << 32) | x1_low;
  s->x2 = ((uint64_t)x2_high << 32) | x2_low;
  s->x3 = ((uint64_t)x3_high << 32) | x3_low;
  s->x4 = ((uint64_t)x4_high << 32) | x4_low;
  
}


#endif /* ROUND_H_ */