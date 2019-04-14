%macro readf 3
mov rax,00
mov rdi,%1
mov rsi,%2
mov rdx,%3
syscall
%endmacro

%macro open 1
mov rax,02
mov rdi,%1
mov rsi,02
mov rdx,0777
syscall
%endmacro

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

%macro write 3
mov rax,01
mov rdi,%1
mov rsi,%2
mov rdx,%3
syscall
%endmacro


section .data
filename: db "file.txt",0
msg: db "File opened succesfully",10
len equ $-msg
err: db "Error in opening file",10
len1 equ $-err
msg1: db "1.Line count 2.space count 3.Character count",10
len2 equ $-msg1



section .bss
global buffer
buffer resb 100
global fd
fd resb 8
global scount,lcount,ccount
scount resb 1
lcount resb 1
ccount resb 1
choice resb 1

global _start
section .text
extern lines,chars,spaces
_start:
open filename
mov rbx,rax
mov [fd],rax
rcl rbx,01h
jc l1
printmsg msg,len
jmp l2
l1:
printmsg err,len1

l2:
printmsg msg1,len2
read choice,02h
x1:
cmp byte[choice],31h
je li
jmp sii
li:
call lines
jmp exit

sii:
cmp byte[choice],32h
je sss
jmp ci

sss:
call spaces
jmp exit

ci:
call chars



exit:
mov rax,60
mov rdi,00
syscall



