.286
code segment
assume cs:code,ds:code,es:code
org 100h
begin:
jmp inst
intro10 proc near
pusha
push es
push ds
push cs
pop ds
mov ax,40h
mov es,ax
mov si,word ptr es:[1ch]
mov al,byte ptr es:[17h]
xor bh,bh
pushf
db 9ah
old_ofs dw 00h
old_segm dw 40h
cmp si,word ptr es:[1ch]
je switch_state
cmp drv_state,3
jumps
je quit
;mov byte ptr es:[si], 'f'
mov ax,es:[si]
cmp al,'!'
jb quit
cmp al,'~'
ja quit
nojumps
cmp ah,35h
ja quit
xor ah,ah
sub al,'!'
lea bx,tablerus
add bx,ax
mov al,byte ptr [bx]
mov es:[si],ax
jmp short quit
switch_state:
mov al,byte ptr es:[17h]
and al,00000011b
cmp al,3
jne state_cmp
cmp drv_state,3
je ddd
mov drv_state,3
mov ah,0fh
int 10h
mov ah,3
int 10h
push dx
mov ah,2
xor dh,dh
mov dl,77
int 10h
mov ah,0eh
mov al,'L'
int 10h
mov ah,0eh
mov al,'A'
int 10h
mov ah,0eh
mov al,'T'
int 10h
pop dx
mov ah,2
int 10h
jmp short state_cmp
ddd:mov drv_state,1
mov ah,0fh
int 10h
mov ah,3
int 10h
push dx
mov ah,2
xor dh,dh
mov dl,77
int 10h
mov ah,0eh
mov al,'R'
int 10h
mov ah,0eh
mov al,'U'
int 10h
mov ah,0eh
mov al,'S'
int 10h
pop dx
mov ah,2
int 10h

state_cmp:
quit:
pop ds
pop es
popa
iret
drv_state db 3
tablerus        db '!�/$:.�?%;+�-�/'
                db '0123456789���=�?'
                db '"���������������'
                DB '������������\�,_'
                db '(��㠯�讫����'
                db '���륣����|�)'
intro10 endp
inst:mov ah,9
lea dx,mes
int 21h
mov ax,3509h
int 21h
mov ax,es
mov old_ofs,bx
mov old_segm,ax
push cs
pop es
lea dx,intro10
mov ax,2509h
int 21h
lea dx,inst
int 27h
mes db 'Keybord Driver for VIST keyboard 1.0',13,10
    db 'This Driver uses INTEL286 or biggest',13,10
    db 'Made by Morozov N.E. 1995',13,10,'$'
code ends
end begin
