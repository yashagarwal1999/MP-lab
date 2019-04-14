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
ff1: db "%lf +i%lf",10,0
ff2:db "%lf -i%lf",10,0
formatpi: db "%d",10,0
formatpf: db "%lf",10,0
formatsf: db "%lf",0
ipart1: db "  +i",10
ipart2: db "  -i",10
two: dq 2
four: dq 4
one: dq -1

section .bss
a resq 1
b resq 1
c resq 1
fourac resq 1
sqrtt resq 1
b2 resq 1
delta resq 1
numo resq 1
deno resq 1
bm resq 1
r1 resq 1
r2 resq 1
i1 resq 1
i2 resq 1

global main
section .text
extern printf
extern scanf
main:
mscanf a
mscanf b
mscanf c
fld qword[b]
fmul qword[b]
fstp qword[b2]
fild qword[four]
fmul qword[a]
fmul qword[c]
fstp qword[fourac]
fld qword[b2]
fsub qword[fourac]
fstp qword[delta]
btr qword[delta],63
fld qword[delta]
fsqrt
fstp qword[sqrtt]
fild qword[one]
fmul qword[b]
fstp qword[bm]
fild qword[two]
fmul qword[a]
fstp qword[deno]
jnc real1
jmp img


img:
fld qword[bm]
fdiv qword[deno]
fstp qword[i1]
fld qword[sqrtt]
fdiv qword[deno]
fstp qword[i2]
jmp print

print:
mov rdi,ff1
sub rsp,8
movsd xmm0,[i1]
movsd xmm1,[i2]
mov rax,2
call printf
add rsp,8
jmp p1

p1:
mov rdi,ff2
sub rsp,8
movsd xmm0,[i1]
movsd xmm1,[i2]
mov rax,2
call printf
add rsp,8
jmp exit



real1:

fld qword[bm]
fadd qword[sqrtt]
fdiv qword[deno]
fstp qword[r1]
mprintf r1
fld qword[bm]
fsub qword[sqrtt]
fdiv qword[deno]
fstp qword[r2]
mprintf r2
jmp exit

exit:
mov rax,60
mov rdi,00
syscall
