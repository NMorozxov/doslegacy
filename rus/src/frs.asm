.286
CODE segment
org 100h
assume cs:code,ds:code,es:code,ss:code
beg:jmp eee
in5:
pusha
push ds
push es
push cs
pop ds
push cs
pop es
mov ah,3ch
xor cx,cx
lea dx,fname
int 21h
mov bx,ax
push bx
mov ax,1130h
mov bh,6
int 10h
push es
pop ds
mov dx,bp
mov ah,40h
mov cx,256*16
pop bx
int 21h
mov ah,3eh
int 21h
pop es
pop ds
popa
iret
eee:
mov ah,9
lea dx,mes1
int 21h
lea dx,in5
mov ax,2505h
int 21h
lea dx,eee1
int 27h
fname 	db 'FRS.FNT',0,'$'
eee1:
mes1 db 'Resident VGA font saver ver 1.0',13,10,'Made by Morozov N.E. 1995',13,10
     db'SHIFT+PRTSCR to save font in to file FRS.fnt',13,10,'$'
code ends
end beg