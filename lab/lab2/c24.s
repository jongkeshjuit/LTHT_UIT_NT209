.section .data
nhap: .string "Nhap chuoi (4 ky tu): "
nhap_len = .-nhap
b: .string "Nhap n (0-9): "
b_len=.-b
endline: .string "\n"
.section .bss
    .lcomm output 5
    .lcomm n 1
    .lcomm a 1
.section .text
    .globl _start
_start:
    movl $4, %eax
    movl $1, %ebx
    movl $nhap, %ecx
    movl $nhap_len, %edx
    int $0x80

    movl $3, %eax
    movl $0, %ebx
    movl $output, %ecx
    movl $5, %edx
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    movl $b, %ecx
    movl $b_len, %edx
    int $0x80

    movl $3, %eax
    movl $0, %ebx
    movl $n, %ecx
    movl $1, %edx
    int $0x80

    movl $output, %eax
    movb 0(%eax), %bl
    movb 1(%eax), %cl
    movb 2(%eax), %dl
    movb 3(%eax), %sil

    movb n, %al
    subb $48, %al

    addb %al, %bl
    addb %al, %cl
    addb %al, %dl
    addb %al, %sil

    cmpb $122, %bl
    jle check_cl
    subb $26, %bl

check_cl:
    cmpb $122, %cl
    jle check_dl
    subb $26, %cl

check_dl:
    cmpb $122, %dl
    jle check_sil
    subb $26, %dl

check_sil:
    cmpb $122, %sil
    jle continue
    subb $26, %sil

continue:
    movl $output, %eax
    movb %bl, 0(%eax)
    movb %cl, 1(%eax)
    movb %dl, 2(%eax)
    movb %sil,3(%eax)

    movl $4, %eax
    movl $1, %ebx
    movl $output, %ecx
    movl $4, %edx
    int $0x80

    movl $4, %eax
    movl $1, %ebx
    movl $endline, %ecx
    movl $1, %edx
    int $0x80

    movl $1, %eax
    int $0x80