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
filename: db "Sort.txt",0
msg: db "opened",10
len equ $-msg
err:db "Error",10
len1 equ $-err

section .bss
buffer resb 100
fd resb 8
count resb 1
c resb 1

global _start
section .text
_start:
xor rax,rax
open filename
mov rbx,rax

mov [fd],rax
rcl rbx,01h
jnc suc
printmsg err,len1
jmp exit
suc:
printmsg msg,len
readf [fd],buffer,100
;printmsg buffer,100
mov byte[count],al

mov byte[c],09h

;dec byte[count]
so:
mov cl,byte[c]
;dec cl

mov rsi,buffer
mov rdi,buffer
inc rdi
s1:
mov al,[rsi]
mov bl,[rdi]
cmp al,bl
jge s2
jmp s3
s2:
mov dl,[rsi]
mov al,[rdi]
mov [rsi],al
mov [rdi],dl
s3:
inc rsi
inc rdi
dec cl
jnz s1
dec byte[count]
jnz so
mov al,byte[c]
printmsg buffer,100
write [fd],buffer,10
close [fd]

exit:
mov rax,60
mov rdi,00
syscall


