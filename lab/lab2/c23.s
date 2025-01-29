.section .data
my_string: .string "Enter a number (1-digit): "
my_string_len = . -my_string
.section .bss
    .lcomm input1 2
    .lcomm input2 2
    .lcomm input3 2
    .lcomm input4 2
    .lcomm sum 4
    .lcomm output 2
.section .text
    .globl _start
_start:
    #init sum = 0
    movl $0, sum
    # print Enter a number1
    movl $4, %eax
    movl $1, %ebx
    movl $my_string, %ecx
    movl $my_string_len, %edx
    int $0x80
    #input1
    movl $3, %eax
    movl $0, %ebx
    movl input1, %ecx
    movl $2, %edx
    int $0x80
    #transfer input1 into number
    movb input1, %al
    subb $'0', %al
    movzx %al, %eax
    addl %eax, sum

    # print Enter a number2
    movl $4, %eax
    movl $1, %ebx
    movl $my_string, %ecx
    movl $my_string_len, %edx
    int $0x80
     #input2
    movl $3, %eax
    movl $0, %ebx
    movl input2, %ecx
    movl $2, %edx
    int $0x80
    #transfer input2 into number
    movb input2, %al
    subb $'0', %al
    movzx %al, %eax
    addl %eax, sum

    # print Enter a number3
    movl $4, %eax
    movl $1, %ebx
    movl $my_string, %ecx
    movl $my_string_len, %edx
    int $0x80
     #input3
    movl $3, %eax
    movl $0, %ebx
    movl input3, %ecx
    movl $2, %edx
    int $0x80
    #transfer input3 into number
    movb input3, %al
    subb $'0', %al
    movzx %al, %eax
    addl %eax, sum

     # print Enter a number4
    movl $4, %eax
    movl $1, %ebx
    movl $my_string, %ecx
    movl $my_string_len, %edx
    int $0x80
     #input4
    movl $3, %eax
    movl $0, %ebx
    movl input4, %ecx
    movl $2, %edx
    int $0x80
    #transfer input4 into number
    movb input4, %al
    subb $'0', %al
    movzx %al, %eax
    addl %eax, sum

     #sum/4
    movl sum, %eax
    sarl $2, %eax
    movl %eax, sum

    #transfer sum into number
    addl $'0', %eax
    movb %al, output
    movb $0x0A, output+1

    #print output
    movl $4, %eax
    movl $1, %ebx
    movl $output, %ecx
    movl $1, %edx
    int $0x80
    #sysexit
    movl $1,%eax
    int $0x80