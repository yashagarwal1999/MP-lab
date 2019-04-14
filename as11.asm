%macro mprintf 1
	mov rdi,formatpf
	sub rsp,8
	movsd xmm0,[%1]
	mov rax,1
	call printf
	add rsp,8
%endmacro

%macro mscanf 1
	mov rdi,formatsf
	mov rax,0
	sub rsp,8
	mov rsi,rsp
	call scanf
	mov r8,qword[rsp]
	mov qword[%1],r8
	add rsp,8
%endmacro

section .data
arr: dq 102.56,104.25,11.1,32.9,21.7
cnt: db 5

meanmsg: db "Mean of the number is ",10
lenmm: equ $-meanmsg
sdmsg: db "Standard deviation is ",10
lensd:  equ $-sdmsg
formatpf: db "%lf",10,0
sum: dq 0
sum1:dq 0
section .bss
mean resq 1
sd resq 1
var resq 1



global main
section .text
extern printf
extern scanf
main:

finit
fldz
mov rsi,arr

loop1:
fld qword[rsi]

fadd qword[sum]
fstp qword[sum]
add rsi,8
dec byte[cnt]
jnz loop1
mov word[cnt],5
fld qword[sum]
fidiv word[cnt]
fstp qword[mean]
mprintf mean
mov rsi,arr
mov cl,05h
l1:

fld qword[rsi]
fmul qword[rsi]
fadd qword[sum1]
fstp qword[sum1]	
add rsi,8
dec cl
jnz l1
mov word[cnt],5
fld qword[sum1]
fidiv word[cnt]
fstp qword[var]
fld qword[mean]
fmul qword[mean]
fstp qword[mean]
fld qword[var]
fsub qword[mean]
fstp qword[var]
mprintf var
fld qword[var]
fsqrt
fstp qword[sd]
mprintf sd

exit:
mov rax,60
mov rdi,00
syscall



