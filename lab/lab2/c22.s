.section .data
        msg: .string "Nhap input: "
        msg_len = .-msg
                endline: .string "\n"
.section .bss
        .lcomm input, 8
.section .text
        .globl _start
_start:
        movl $4,%eax
        movl $1,%ebx
        movl $msg, %ecx
        movl $msg_len, %edx
        int $0x80

        movl $3, %eax
        movl $0, %ebx
        movl $input, %ecx
        movl $8, %edx
        int $0x80

        movl $input, %eax
        movb $0, 2(%eax)
        movb $0, 3(%eax)

        movl $4, %eax
        movl $1, %ebx
        movl $input, %ecx
        movl $9, %edx
        int $0x80

        movl $4, %eax
        movl $1, %ebx
        movl $endline, %ecx
        movl $1, %edx
        int $0x80

        movl $1, %eax
        int $0x80