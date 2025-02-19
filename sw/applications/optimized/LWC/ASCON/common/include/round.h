#ifndef ROUND_H_
#define ROUND_H_

#include "ascon.h"
#include "printstate.h"

static inline uint64_t ROR(uint64_t x, int n) {
  return (x << (64 - n)) | (x >> n);
}

/*
static inline void ROUND(state_t* s, uint8_t C) {
}*/


 static inline void ROUND(state_t* s, int nr) {
	uint32_t Abe_low;
    uint32_t Abe_high;

	asm volatile (".insn r 0x4b, 0x004, 0, x0, %[rs1], %[rs2], %[i]\r\n": : [rs1] "r" (s->x[0] ), [rs2] "r" ((s->x[0] >> 32) ), [i] "r" (0): );
    asm volatile (".insn r 0x4b, 0x004, 0, x0, %[rs1], %[rs2], %[i]\r\n": : [rs1] "r" (s->x[1] ), [rs2] "r" ((s->x[1] >> 32) ), [i] "r" (2): );
    asm volatile (".insn r 0x4b, 0x004, 0, x0, %[rs1], %[rs2], %[i]\r\n": : [rs1] "r" (s->x[2] ), [rs2] "r" ((s->x[2] >> 32) ), [i] "r" (4): );
    asm volatile (".insn r 0x4b, 0x004, 0, x0, %[rs1], %[rs2], %[i]\r\n": : [rs1] "r" (s->x[3] ), [rs2] "r" ((s->x[3] >> 32) ), [i] "r" (6): );
    asm volatile (".insn r 0x4b, 0x004, 0, x0, %[rs1], %[rs2], %[i]\r\n": : [rs1] "r" (s->x[4] ), [rs2] "r" ((s->x[4] >> 32) ), [i] "r" (8): );

    asm volatile (".insn r 0x4b, 0x004, 1, x0, %[rs1], %[rs2], x0\n\t" : : [rs1] "r" (1) , [rs2] "r" (nr): );


	for(int i=0;i<nr;i++){
		asm volatile ("nop");
	}


	for(int i=0; i<10; i+=2){
		asm volatile (".insn r 0x4b, 0x004, 2, %[rd_low], %[rs1], x0, x0\r\n": [rd_low] "=r" (Abe_low) : [rs1] "r" (i): );
        	asm volatile (".insn r 0x4b, 0x004, 2, %[rd_high], %[rs1], x0, x0\r\n": [rd_high] "=r" (Abe_high): [rs1] "r" (i+1): );
        	s->x[i/2] = ((uint64_t)Abe_high << 32) | Abe_low;
	}

}

#endif /* ROUND_H_ */
