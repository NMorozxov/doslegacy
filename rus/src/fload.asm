CODE segment
org 100h
assume cs:code,ds:code,es:code,ss:code
beg:
jmp short inst
fname db 60 dup (0)
inst:mov ah,9
lea dx,mes1
int 21h
mov bx,80h
cmp byte ptr es:[bx],0
jne cont
mov ah,9
lea dx,mes2
int 21h
int 20h
cont:
push cs
pop es
mov bx,80h
mov cl,byte ptr es:[bx]
xor ch,ch
dec cx
lea di,fname
mov si,82h
cld 
rep movsb
;strname:
;mov bx,cx
;add bx,82h
;mov ax,es:[bx]
;lea bx,fname
;add bx,cx
;mov es:[bx],ax
;loop strname

mov ax,3d00h
lea dx,fname
int 21h
jnc cont2
mov ah,9
lea dx,mes3
int 21h
int 20h
cont2:mov bx,ax
mov ah,3fh
lea dx,font
mov cx,256*16
int 21h
mov ah,3eh
int 21h
push cs
pop es
lea bp,font
mov ax,1100h
mov bx,1000h
mov cx,100h
xor dx,dx
int 10h
int 20h
font db 256*16 dup (0)
mes3 db 'File not find',13,10,'$'
mes1 db 'VGA text font loader 2.0',13,10,'Made by Morozov N.E 1995',13,10,'$'
mes2 db 'Usage FLOAD.COM <file.fnt>',13,10,'$'
code ends
end beg