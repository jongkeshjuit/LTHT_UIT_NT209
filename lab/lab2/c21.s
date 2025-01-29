.section .data
msg:    .string "Love UIT"
        msg_len = .-msg
.section .bss
        .lcomm output, 9
.section .text
        .globl _start
_start:

        movl $msg_len, %eax
        addl $47, %eax

        movl %eax, output

        movl $4, %eax
        movl $1, %ebx
        movl $output, %ecx
        movl $1, %edx
        int $0x80

        movl $1, %eax
        int $0x80