%macro printmsg  2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro


section .data
msg: db "1.Hex to Bcd 2.Bcd to Hex 3.Exit",10
len equ $-msg
msg1: db "Enter number",10
len1 equ $-msg1

section .bss
hex resb 4
bcd resb 5
choice resb 1
h resb 1
hh resb 2
global _start
section .text
_start:
printmsg msg,len
read choice,02h
;printmsg choice,01h
cmp byte[choice],31h
jz c1

c1:
call HTB






exit:  ;exit
mov rax,60
mov rdi,0
syscall

HTB:
printmsg msg1,len1
read hex,04h
;printmsg hex,04h
jz HexAscii

HexAscii:
mov esi,hex
mov ax,00
mov cl,04h


loop1:
rol ax,04
mov bl,byte[esi]
cmp bl,39h
jbe next
sub bl,07h
next:
sub bl,30h
add al,bl
inc rsi
dec cl
jnz loop1


xor dx,dx
mov bl,04h
l1:

mov cl,0Ah
div cl
push dx
dec bl
jnz l1
pop ax
mov bl,al
tt:
add bl,30h
;mov esi,
ttt:
;printmsg h,01
r:

ret





