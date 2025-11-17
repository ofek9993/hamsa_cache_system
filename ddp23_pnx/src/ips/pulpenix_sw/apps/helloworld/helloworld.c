#include <ddp23_libs.h>

void __attribute__((noinline))
seperate_id_name(char *s, char *id, char *name)
{
    asm volatile(
        "mv  t0,%[s]\n"
        "mv  t1,%[id]\n"
        "mv  t2,%[name]\n"
    "1:\n"
        "lb  t3,0(t0)\n"
        "beqz t3,2f\n"
        "addi t0,t0,1\n"
        "li  t4,48\n"
        "li  t5,57\n"
        "blt t3,t4,3f\n"
        "bgt t3,t5,3f\n"
        "sb  t3,0(t1)\n"
        "addi t1,t1,1\n"
        "j   1b\n"
    "3:\n"
        "sb  t3,0(t2)\n"
        "addi t2,t2,1\n"
        "j   1b\n"
    "2:\n"
        "sb  zero,0(t1)\n"
        "sb  zero,0(t2)\n"
        :
        : [s]"r"(s),[id]"r"(id),[name]"r"(name)
        : "t0","t1","t2","t3","t4","t5","memory"
    );
}

void __attribute__((noinline))
asm_printf(char *p)
{
    volatile char *thr = (char *)(UART_BASE_ADDR + 0x00);
    volatile char *lsr = (char *)(UART_BASE_ADDR + 0x14);

    /* template from the hand-out */
    asm volatile(
    "1:\n"
        "lb  t0,0(%[p])\n"
        "beqz t0,3f\n"
    "2:\n"
        "lb  t1,0(%[lsr])\n"
        "beqz t1,2b\n"
        "sb  t0,0(%[thr])\n"
        "addi %[p],%[p],1\n"
        "j   1b\n"
    "3:\n"
        : [p] "+r"(p)
        : [lsr]"r"(lsr), [thr]"r"(thr)
        : "t0","t1","memory"
    );
}

int main(void)
{
    char *in = "ddp2318h21l495";
    char id[32]   = {0};
    char name[32] = {0};

    seperate_id_name(in, id, name);

    asm_printf("id = ");
    asm_printf(id);
    asm_printf("\nname = ");
    asm_printf(name);
    asm_printf("\n\nHELLO DDP21/ADVLSI\n");

    sim_finish();
    return 0;
}
