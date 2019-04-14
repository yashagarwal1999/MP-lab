%macro readf 3
mov rax,00
mov rdi,%1
mov rsi,%2
mov rdx,%3
syscall
%endmacro

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
mess: db "The number of lines are: "
len6 equ $-mess
mess1: db "The number of spaces are: "
len7 equ $-mess1
cha: db "Enter the characters to be searched",10
lenc equ $-cha
newline:db 10,13
section .bss
co resb 1
extern scount,lcount,ccount
extern buffer
extern fd
section .text
global lines,chars,spaces 

lines:
readf [fd],buffer,100
mov rsi,buffer
mov byte[lcount],00h
xor rcx,rcx

lc:
mov rcx,100
lcc:
mov bl,[rsi]
cmp bl,0Ah
je l4
jmp l5
l4:
inc byte[lcount]
l5:
inc rsi
dec rcx
jnz lcc
mov rsi,lcount
mov al,byte[lcount]
call h2a
printmsg mess,len6
printmsg lcount,02h
printmsg newline,01
ret

spaces:
readf [fd],buffer,100
xor rcx,rcx
mov rcx,100
mov rsi,buffer
mov byte[scount],00h
loop:
mov bl,[rsi]
cmp bl,20h
jne s1
inc byte[scount]
s1:
inc rsi 
dec rcx
jnz loop
mov rsi,scount
mov al,byte[scount]
call h2a
printmsg mess1,len7
printmsg scount,02h
printmsg newline,01
ret

chars:
printmsg cha,lenc
read co,01h
readf [fd],buffer,100
mov rsi,buffer
xor rcx,rcx
mov rcx,100
mov byte[ccount],00h
c11:
mov bl,[rsi]
cmp bl,byte[co]
jne c12
inc byte[ccount]
c12:
inc rsi
dec rcx
jnz c11
mov al,byte[ccount]
mov rsi,ccount
call h2a
printmsg ccount,02h

h2a:
mov cl,02h
h1:
rol al,04h
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
