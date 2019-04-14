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

section .data
fact: db "fact",10
len equ $-fact

section .bss
n1 resb 1
res resb 16

global _start
section .text
_start:
pop rbx
pop rbx
pop rbx
xor rax,rax
mov rax,rbx
;mov rsi,n1
call a2h
bb:
xor rax,rax
mov al,dl
xor rdx,rdx
mov rdx,rax
mov rcx,rax
mov rax,01h

call ff
mov rsi,res
call h2a
printmsg res,16

exit:
mov rax,60
mov rdi,00
syscall

h2a:
mov cl,16
a1:
rol rax,04h
mov bl,al
and bl,0fh
cmp bl,09h
jbe a2
add bl,07h
a2:
add bl,30h
mov [rsi],bl
inc rsi
dec cl
jnz a1
ret



a2h:
xor rdx,rdx
mov cl,02h
h1:
rol ax,04h
mov bl,al
cmp bl,39h
jbe h2
sub bl,07h
h2:
sub bl,30h
rol dl,04h
add dl,bl
h3:
dec cl
jnz h1
ret

ff:
cmp dl,01h
jne ff1
ret
ff1:
push rdx
dec dl
d1:
call ff
pop rcx
mul rcx
ret
