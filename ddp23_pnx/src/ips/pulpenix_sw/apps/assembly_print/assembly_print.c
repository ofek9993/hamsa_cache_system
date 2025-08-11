// Yonatan (Yoni) Pugachov - 215015272 // 

#include <ddp23_libs.h>
void __attribute__ ((noinline)) seperate_id_name (char * id_number, char* id, char* name) {
    asm volatile (
        "mv t0, %[id_number]\n"     // t0 = pointer to id_number
        "mv t1, %[id]\n"            // t1 = pointer to id
        "mv t2, %[name]\n"          // t2 = pointer to name

        "1:\n"
        "lb t3, 0(t0)\n"            // Load byte from id_number
        "beq t3, zero, 2f\n"        // Null terminator? done

        // Digit check
        "li t4, 48\n"
        "li t5, 57\n"
        "blt t3, t4, letter_check\n" // Smaller than 49 (='0') -> jump to letters
        "bgt t3, t5, letter_check\n" // Bigger than 57 (='9') -> jump to letters 

        // It's a digit -> store in id
        "sb t3, 0(t1)\n"
        "addi t1, t1, 1\n"
        "j next_char\n"

        // It's a letter -> store in name
        "letter_check:\n"
        "sb t3, 0(t2)\n"
        "addi t2, t2, 1\n"

        // Move to next character
        "next_char:\n"
        "addi t0, t0, 1\n"          
        "j 1b\n"

        "2:\n"
        // Store null terminator at the end of both strings
        "sb zero, 0(t1)\n"
        "sb zero, 0(t2)\n"

        :
        : [id_number] "r" (id_number),
          [id] "r" (id),
          [name] "r" (name)
        : "t0", "t1", "t2", "t3", "t4", "t5", "memory"
    );
}

#define UART_REG_RBR    (UART_BASE_ADDR + 0x00) // Write here per your custom spec
#define UART_REG_LSR    (UART_BASE_ADDR + 0x14) // Check if ready

void __attribute__ ((noinline)) asm_printf(char* p) {
    asm volatile (
        "mv t0, %[str]\n"              // t0 = pointer to string

        "1:\n"
        "lb t1, 0(t0)\n"               // Load byte
        "beq t1, zero, 2f\n"           // Null terminator? Done

        "3:\n"
        "lb t2, 0(%[lsr])\n"           // Read LSR
        "andi t2, t2, 0x20\n"          // Bit 5 = THR
        "beq t2, zero, 3b\n"           // Wait until THR is empty

        "sb t1, 0(%[rbr])\n"           // Write byte to UART
        "addi t0, t0, 1\n"             // Next char
        "j 1b\n"

        "2:\n"                         // Done
        :
        : [str] "r" (p),
          [rbr] "r" (UART_REG_RBR),
          [lsr] "r" (UART_REG_LSR)
        : "t0", "t1", "t2", "memory"
    );
}

int main() {
    char * id_number = "yo215ni015puga272chov";
    char volatile ide[1024];
    char volatile namee[1024];
    char * id = ide;
    char * name = namee;
    seperate_id_name(id_number, id, name);
    printf("\n\n");
    asm_printf("UART_OUTPUT:\n");
    asm_printf(id);
    asm_printf(name);
    printf("\n\n");
    sim_finish();
    return 0;
}