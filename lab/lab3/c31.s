.section .data
	tang: .string "Tang dan"
	ktang: .string "Khong tang dan"

.section .bss
	.lcomm input, 4
	.lcomm outputT, 9
	.lcomm outputK, 15

.section .text
	.globl _start

_start:
    # Read 4 bytes from stdin into input
    movl $3, %eax
    movl $0, %ebx
    movl $input, %ecx
    movl $4, %edx
    int $0x80
    
    movl $input, %esi

    # Convert the first character to a number
    movzbl 0(%esi), %eax
    sub $'0', %al
    mov %al, %bh

    # Convert the second character to a number and compare
    movzbl 1(%esi), %eax
    sub $'0', %al
    mov %al, %bl
    cmp %bh, %bl
    jle .NOT_INCREASING
    mov %bl, %bh

    # Convert the third character to a number and compare
    movzbl 2(%esi), %eax
    sub $'0', %al
    mov %al, %bl
    cmp %bh, %bl
    jle .NOT_INCREASING
    mov %bl, %bh

    # Convert the fourth character to a number and compare
    movzbl 3(%esi), %eax
    sub $'0', %al
    mov %al, %bl
    cmp %bh, %bl
    jle .NOT_INCREASING

    # Print "Tang dan"
    movl $4, %eax
    movl $1, %ebx
    movl $tang, %ecx
    movl $9, %edx
    int $0x80
    jmp .END

.NOT_INCREASING:
    # If not increasing, print "Khong tang dan"
    movl $4, %eax
    movl $1, %ebx
    movl $ktang, %ecx
    movl $15, %edx
    int $0x80

.END:
    movl $1, %eax
    int $0x80