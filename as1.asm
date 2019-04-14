%macro printmsg 2
mov rax,01
mov rdi,01
mov rsi,%1
mov rdx,%2
syscall
%endmacro

section .data
arr: db 02h,03h,22h,36h,0f2h,0cbh
newline: db 10
section .bss
posi resb 1
negi resb 1

global _start
section .text 
_start:
mov cl,06h
mov esi,arr
mov byte[posi],0h
mov byte[negi],0h
jmp count


count:
mov bl,[esi]
rcl bl,01h
jnc ne
inc byte[negi]

jmp x
ne:
inc byte[posi]
x:
inc esi
dec cl
jnz count
mov al,byte[posi]
mov esi,posi
call Ass
printmsg posi,02h
xor al,al
mov al,byte[negi]
mov esi,negi
call Ass
printmsg newline,01h
printmsg negi,02h
jmp exit

;exit
exit:
mov rax,60
mov rdi,0
syscall

Ass:
mov cl,02h

l:
rol al,04h
mov bl,al
and bl,0fh
cmp bl,09h
jbe l1
add bl,07h
l1:
add bl,30h
s:
mov [esi],bl
inc esi
dec cl
jnz l
ret
	

