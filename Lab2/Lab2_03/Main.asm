.686
.model flat,stdcall
.stack 100h
.data
X dw 6DA9h ; �������� ������
Y dw 11FAh
L dw ?     ; ���������� �����������
M dw ?
R dw ?

.code
; ������������ ���1
ADR1:
mov ax,L   ; R=27E1 xor L
xor ax,27E1h
mov R,ax
ret

; ������������ ���2
ADR2:
add R,67A1h ; R=R+67A1-L
mov ax,L
sub R,ax
ret

; �������� ���������
Start:
mov ax,X     ; L=X-4Y
mov ecx,4
@@:sub ax,Y
   loop @b
mov L,ax
xor ax,Y     ; M=L xor Y
mov M,ax
cmp M,0      ; ��������� M � ����
jg W1        
 neg ax      ; ����� M<=0: R=-M
 mov R,ax
 jmp T3
W1:
 and ax,0f0fh ; ����� M>0: R=M & 0F0F
 mov R,ax
T3:
cmp R,0      ; ��������� R � ����
je W3
 call ADR2   ; R<>0 - ������� � ������������ ���2
 jmp Fin
W3:
 call ADR1   ; R=0 - ������� � ������������ ���1
Fin:
ExitProcess PROTO STDCALL :DWORD
Invoke ExitProcess,0
End Start