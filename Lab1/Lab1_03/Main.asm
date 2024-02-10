.686
.model flat,stdcall
.stack 100h
.data
X dd 58  ; Переменные
Y dd 23
Z dd 11
M dd ?
.code
Start:
mov edx,X    ; EDX=X+Y+Z
add edx,Y
add edx,Z
mov eax,X    ; EAX=(X+Y+Z)&X
and eax,edx
mov ecx,32   ; EBX=Y'
L:rol Y,1    ; Цикл побитового "разворота" Y
  rcr ebx,1
  loop L
and ebx,edx  ; EBX=(X+Y+Z)&Y'
sub eax,ebx  ; EAX=((X+Y+Z)&X)-((X+Y+Z)&Y')
mov M,eax    ; Сохранение результата
ExitProcess PROTO STDCALL :DWORD
Invoke ExitProcess,0
End Start