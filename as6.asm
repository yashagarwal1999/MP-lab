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
newline: db 10

section .bss
msw resb 02
gdt resb 06
ldt resb 06
idt resb 02
val resb 01
global _start
section .text
_start:
smsw word[msw]
test word[msw],0001h
sgdt[gdt]
sldt[ldt]
sidt[idt]
gd:
mov rsi,gdt
mov ax,word[gdt]
call h2a
printmsg gdt,04h

ld:
mov rsi,ldt
mov ax,word[ldt]
call h2a
printmsg newline,01h
printmsg ldt,04h

id:
mov rsi,idt
mov ax,word[idt]
call h2a
printmsg newline,01h
printmsg idt,04h

exit:
mov rax,60
mov rdi,00
syscall

h2a:
mov cl,04h
h11:
xor bx,bx
rol ax,04h
mov bl,al
and bl,0fh
cmp bl,09h
jbe h1
add bl,07h
h1:
add bl,30h
mov [rsi],bl
inc rsi
h2:
dec cl
jnz h11
ret


