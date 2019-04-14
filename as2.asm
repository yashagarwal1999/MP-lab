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
arr: db 12h,14h,18h,20h
cnt: db 4
msg: db "1.over 2.non",10
len equ $-msg
space: db "   "
lens equ $-space
newline: db 10
section .bss 
choice resb 1
arr1 resb 4
no resb 1

global _start
section .text
_start:
printmsg msg,len
read choice,02h
cmp byte[choice],31h
je over
je non

non:
mov cl,04h
mov rsi,arr
mov rdi,arr1
n1:
mov rax,rsi
call h2aa
printmsg rsi,10h
printmsg space,lens
mov al,[rsi]
mov [rdi],al
call h2a
printmsg no,01h
printmsg space,lens
;printmsg rdi,16
printmsg no,01h
printmsg newline,01h

inc rsi 
inc rdi
dec cl
jnz n1

over:

exit:
mov rax,60
mov rdi,00
syscall

h2aa:
mov cl,04
a1:
rol rax,04h
mov bl,al
and bl,0fh
cmp bl,09h
jbe a2
add bl,07h
a2:
add bl,30h
mov byte[no],bl
printmsg no,01h
dec cl
jnz a1
ret

h2a:
mov cl,02h
xor al,al
h1:
rol al,04h
mov bl,byte[rsi]
cmp bl,39h
jbe h2
add bl,07h
h2:
add bl,30h
add al,bl
h3:
inc rsi
dec cl
jnz h1
mov byte[no],al

ret
