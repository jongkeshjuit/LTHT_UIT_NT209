.section .data
    input_string: .string "Nhap nam sinh gom 4 chu so: "
    input_string_length = .-input_string
    Dang_hoc_tai_UIT: .string "Dang hoc tai UIT\n"
    Dang_hoc_tai_UIT_length = .-Dang_hoc_tai_UIT
    Chua_vao_UIT: .string "Chua vao UIT\n"
    Chua_vao_UIT_length = .-Chua_vao_UIT
    Da_tot_nghiep: .string "Da tot nghiep\n"
    Da_tot_nghiep_length = .-Da_tot_nghiep
    Tuoi: .string "Tuoi: "
    Tuoi_length = .-Tuoi
    Du_kien_tot_nghiep: .string "\nDu kien tot nghiep: "
    Du_kien_tot_nghiep_length = .-Du_kien_tot_nghiep
    Du_kien_vao_UIT: .string "\nDu kien vao UIT: "
    Du_kien_vao_UIT_length = .-Du_kien_vao_UIT
    Nam_da_tot_nghiep: .string "\nNam da tot nghiep: "
    Nam_da_tot_nghiep_length = .-Nam_da_tot_nghiep
    newline: .string "\n"
    space: .string " "
    buffer: .space 10
    num_buffer: .space 10

.section .bss
    .lcomm NamSinh, 4
    .lcomm TuoiHT, 4
    .lcomm KetQua, 4
    .lcomm TempNum, 4

.section .text
.globl _start
_start:
    # In thong bao nhap
    movl $4, %eax
    movl $1, %ebx
    movl $input_string, %ecx
    movl $input_string_length, %edx
    int $0x80

    # Nhap nam sinh
    movl $3, %eax
    movl $0, %ebx
    movl $buffer, %ecx
    movl $5, %edx    # 4 chu so + newline
    int $0x80

    # Chuyen chuoi thanh so
    xorl %eax, %eax      # Xoa eax
    movl $buffer, %esi   # Dia chi buffer vao esi
    movl $0, %ecx        # Reset bien dem
    movl $10, %ebx
    jmp .test
.for:	
	mull %ebx
	addb (%esi), %al
	subb $48, %al
	incl %esi
	incl %ecx
.test:
	cmpl $4, %ecx
	jge .exit_for
	jmp .for
.exit_for:
	movl %eax, NamSinh

    # Tinh tuoi
    movl $2024, %edx    # Nam hien tai
    subl NamSinh, %edx
    movl %edx, TuoiHT

    # So sanh tuoi
    movl TuoiHT, %eax
    cmpl $18, %eax      # So sanh voi 18
    jl chua_vao_uit     # Neu < 18, nhay toi chua_vao_uit
    cmpl $22, %eax      # So sanh voi 22
    jle dang_hoc        # Neu <= 22, nhay toi dang_hoc
    jmp da_tot_nghiep   # Con lai la da tot nghiep

chua_vao_uit:
    # In "Chua vao UIT"
    movl $4, %eax
    movl $1, %ebx
    movl $Chua_vao_UIT, %ecx
    movl $Chua_vao_UIT_length, %edx
    int $0x80

    # In "Tuoi: "
    movl $4, %eax
    movl $1, %ebx
    movl $Tuoi, %ecx
    movl $Tuoi_length, %edx
    int $0x80

    # Xu ly in tuoi
    movl TuoiHT, %eax
    movl $10, %ebx
    movl $0, %edx
    divl %ebx           # Lay chu so hang chuc
    addl $48, %eax      # Chuyen thanh ky tu
    movb %al, num_buffer
    addl $48, %edx      # Chuyen phan du thanh ky tu
    movb %dl, num_buffer + 1

    # In tuoi
    movl $4, %eax
    movl $1, %ebx
    movl $num_buffer, %ecx
    movl $2, %edx      # In 2 ky tu
    int $0x80

    # In thong bao du kien vao UIT
    movl $4, %eax
    movl $1, %ebx
    movl $Du_kien_vao_UIT, %ecx
    movl $Du_kien_vao_UIT_length, %edx
    int $0x80

    # Tinh nam du kien vao UIT
    movl NamSinh, %eax
    addl $18, %eax
    movl %eax, KetQua
    jmp print_ketqua

dang_hoc:
    # In "Dang hoc tai UIT"
    movl $4, %eax
    movl $1, %ebx
    movl $Dang_hoc_tai_UIT, %ecx
    movl $Dang_hoc_tai_UIT_length, %edx
    int $0x80

    # In "Tuoi: "
    movl $4, %eax
    movl $1, %ebx
    movl $Tuoi, %ecx
    movl $Tuoi_length, %edx
    int $0x80

    # Xu ly in tuoi
    movl TuoiHT, %eax
    movl $10, %ebx
    movl $0, %edx
    divl %ebx           # Lay chu so hang chuc
    addl $48, %eax      # Chuyen thanh ky tu
    movb %al, num_buffer
    addl $48, %edx      # Chuyen phan du thanh ky tu
    movb %dl, num_buffer + 1

    # In tuoi
    movl $4, %eax
    movl $1, %ebx
    movl $num_buffer, %ecx
    movl $2, %edx      # In 2 ky tu
    int $0x80

    # In thong bao du kien tot nghiep
    movl $4, %eax
    movl $1, %ebx
    movl $Du_kien_tot_nghiep, %ecx
    movl $Du_kien_tot_nghiep_length, %edx
    int $0x80

    # Tinh nam du kien tot nghiep
    movl NamSinh, %eax
    addl $22, %eax
    movl %eax, KetQua
    jmp print_ketqua

da_tot_nghiep:
    # In "Da tot nghiep"
    movl $4, %eax
    movl $1, %ebx
    movl $Da_tot_nghiep, %ecx
    movl $Da_tot_nghiep_length, %edx
    int $0x80

    # In "Tuoi: "
    movl $4, %eax
    movl $1, %ebx
    movl $Tuoi, %ecx
    movl $Tuoi_length, %edx
    int $0x80

    # Xu ly in tuoi
    movl TuoiHT, %eax
    movl $10, %ebx
    movl $0, %edx
    divl %ebx           # Lay chu so hang chuc
    addl $48, %eax      # Chuyen thanh ky tu
    movb %al, num_buffer
    addl $48, %edx      # Chuyen phan du thanh ky tu
    movb %dl, num_buffer + 1

    # In tuoi
    movl $4, %eax
    movl $1, %ebx
    movl $num_buffer, %ecx
    movl $2, %edx      # In 2 ky tu
    int $0x80

    # In thong bao nam da tot nghiep
    movl $4, %eax
    movl $1, %ebx
    movl $Nam_da_tot_nghiep, %ecx
    movl $Nam_da_tot_nghiep_length, %edx
    int $0x80

    # Lay nam da tot nghiep
    movl NamSinh, %eax
    addl $22, %eax
    movl %eax, KetQua

print_ketqua:
	#Chuyen so thanh chuoi
	movl $TempNum+3, %esi
	movl KetQua, %eax
.while:
	cmpl $0, %eax
	je .exit_while
	movl $0, %edx
	movl $10, %ebx
	divl %ebx
	addl $48, %edx
	addl %edx, (%esi)
	decl %esi
	jmp .while
.exit_while:

    # In so
    movl $4, %eax
    movl $1, %ebx
    movl $TempNum, %ecx
    movl $4, %edx
    int $0x80

    # In xuong dong
    movl $4, %eax
    movl $1, %ebx
    movl $newline, %ecx
    movl $1, %edx
    int $0x80

exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80