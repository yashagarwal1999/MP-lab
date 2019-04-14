%macro printmsg 2
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro read 2
mov rax,00
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro


section .data
msg: db "1.suc 2.shi",10
len: equ $-msg

section .bss
n1 resb 2
n2 resb 2
num1 resb 1
num2 resb 1
res resb 4
choice resb 1
global _start
section .text
_start:

read n2,03h
mov rsi,n2
xor ax,ax
call a2h
mov byte[num2],al

read n1,03h
mov rsi,n1
xor ax,ax
call a2h
mov byte[num1],00h
mov byte[num1],al



printmsg msg,len
read choice,01h
cmp byte[choice],31h
je Do
jmp shift


shift:
xor ax,ax
xor bx,bx
xor cx,cx
xor dx,dx
mov cl,byte[num1]
mov bl,byte[num2]
mov dl,08h
mov al,00h
S1:
shl bl,01h
jnc S2
add al,cl
S2:
shl al,01h

S3:
dec cl
jnz S1
S4:

Do:
xor ax,ax
xor bx,bx
mov cl,byte[num2]
xor bx,bx
mov bl,byte[num1]
mov al,00h
d1:

s1:
add ax,bx
s2:
dec cl
jnz s1
mov rsi,res
call h2a
printmsg res,4




exit:
mov rax,60
mov rdi,00
syscall


h2a:
mov cl,04h
h1:
rol ax,04h
mov bl,al
and bl,0fh
cmp bl,09h
jbe h2
add bl,07h
h2:
add bl,30h
mov [rsi],bl
inc rsi
dec cl
jnz h1
ret








a2h:
xor bx,bx
xor ax,ax
mov cl,02h
a1:
rol al,04h
mov bl,[rsi]
cmp bl,39h
jbe a2
sub bl,07h
a2:
sub bl,30h
add al,bl
a3:
inc rsi
dec cl
jnz a1
ret
