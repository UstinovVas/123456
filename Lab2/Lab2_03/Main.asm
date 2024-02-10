.686
.model flat,stdcall
.stack 100h
.data
X dw 6DA9h ; Исходные данные
Y dw 11FAh
L dw ?     ; Переменные результатов
M dw ?
R dw ?

.code
; Подпрограмма АДР1
ADR1:
mov ax,L   ; R=27E1 xor L
xor ax,27E1h
mov R,ax
ret

; Подпрограмма АДР2
ADR2:
add R,67A1h ; R=R+67A1-L
mov ax,L
sub R,ax
ret

; Основлая программа
Start:
mov ax,X     ; L=X-4Y
mov ecx,4
@@:sub ax,Y
   loop @b
mov L,ax
xor ax,Y     ; M=L xor Y
mov M,ax
cmp M,0      ; Сравнение M с нулём
jg W1        
 neg ax      ; Ветвь M<=0: R=-M
 mov R,ax
 jmp T3
W1:
 and ax,0f0fh ; Ветвь M>0: R=M & 0F0F
 mov R,ax
T3:
cmp R,0      ; Сравнение R с нулём
je W3
 call ADR2   ; R<>0 - переход в подпрограмму АДР2
 jmp Fin
W3:
 call ADR1   ; R=0 - переход в подпрограмму АДР1
Fin:
ExitProcess PROTO STDCALL :DWORD
Invoke ExitProcess,0
End Start