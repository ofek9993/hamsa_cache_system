#include <ddp23_libs.h>

void __attribute__((noinline))
seperate_id_name(char *id_number, char *id, char *name)
{
    asm volatile (
        "mv  t0, %[src]\n"
        "mv  t1, %[dst_id]\n"
        "mv  t2, %[dst_name]\n"

        "1:\n"
        "lb  t3, 0(t0)\n"
        "beqz t3, 2f\n"
        "addi t0, t0, 1\n"

        "li  t4, 48\n"
        "li  t5, 57\n"
        "blt t3, t4, 3f\n"
        "bgt t3, t5, 3f\n"

        "sb  t3, 0(t1)\n"
        "addi t1, t1, 1\n"
        "j   1b\n"

        "3:\n"
        "sb  t3, 0(t2)\n"
        "addi t2, t2, 1\n"
        "j   1b\n"

        "2:\n"
        "sb  zero, 0(t1)\n"
        "sb  zero, 0(t2)\n"
        :
        : [src]      "r"(id_number),
          [dst_id]   "r"(id),
          [dst_name] "r"(name)
        : "t0","t1","t2","t3","t4","t5","memory"
    );
}

int main(void)
{
    char *id_number = "is1234rae56l789";
    char volatile ide[1024]   = {0};
    char volatile namee[1024] = {0};
    char *id   = (char *)ide;
    char *name = (char *)namee;

    seperate_id_name(id_number, id, name);

    printf("id = %s", id);
    printf("name= %s", name);
    printf("\n\nHELLO DDP21/ADVLSI\n\n");

    sim_finish();
    return 0;
}
