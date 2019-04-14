%macro read 2
mov rax,00
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro printmsg 2
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro open 1
mov rax,02
mov rdi,%1
mov rsi,02
mov rdx,0777
syscall
%endmacro

%macro readf 3
mov rax,00
mov rdi,%1
mov rsi,%2
mov rdx,%3
syscall
%endmacro

%macro write 3
mov rax,01
mov rdi,%1
mov rsi,%2
mov rdx,%3
syscall
%endmacro
%macro close 1
mov rax,03
mov rdi,%1
syscall
%endmacro

section .data
co: db "copied",10
lenc equ $-co
del: db "deleted",10
lend: equ $-del


section .bss
buffer resb 100
fd1 resb 8
fd2 resb 8

global _start
section .text
_start:
pop rbx
pop rbx
inc rbx
inc rbx
mov al,[rbx]
cmp al,43h
je Copy
cmp al,44h
je Del
jmp Type

Type:
pop rbx
open rbx
mov [fd1],rax
readf [fd1],buffer,100
printmsg buffer,100


jmp exit

Del:
pop rbx
mov rax,87
mov rdi,rbx
syscall
printmsg del,lend
jmp exit

Copy:
pop rbx 
open rbx
mov [fd1],rax
readf [fd1],buffer,23
pop rbx
open rbx
mov [fd2],rax
write [fd2],buffer,23
printmsg co,lenc
close [fd1]
close [fd2]

jmp exit


exit:
mov rax,60
mov rdi,00
syscall
