CODE segment
org 100h
assume cs:code,ds:code,es:code,ss:code
beg:
mov ah,9
lea dx,mes1
int 21h
mov bx,80h
cmp byte ptr es:[bx],0
jne cont
mov ah,9
lea dx,mes2
int 21h
cont:mov si,5dh
lea di,fname
mov cx,8
cld
rep movsb  
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
int 20h
fname 	db 8 dup (0)
	db '.FNT',0,'$'
mes1 db 'VGA font saver ver 1.0',13,10,'Made by Morozov N.E. 1995',13,10,'$'
mes2 db 'Usage FSAVE <file.fnt>',13,10,'$'
code ends
end beg