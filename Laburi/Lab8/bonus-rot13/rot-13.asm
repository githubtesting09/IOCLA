%include "io.inc"

section .data
    string db "ana are mere", 0

section .text
global CMAIN

rot13:
    push ebp
    lea ebp, [esp]
    
    xor ebx, ebx
    mov ecx, [ebp + 8]
rot13_on_a_char:
    mov bl, [ecx]
    
    test bl, bl
    jz return
    cmp bl, ' '
    je next_char
    cmp bl, 'm'
    ja above_13

    lea eax, [ebx + 13]
    jmp change_char
above_13:
    lea eax, [ebx + 'a' + 12 - 'z']

change_char:
    mov [ecx], al

next_char:
    inc ecx
    jmp rot13_on_a_char
 
return:
    leave
    ret

CMAIN:
    push ebp
    mov ebp, esp
    
    push string
    call rot13
    
    push string
    call puts
    
    lea esp, [ebp]
    xor eax, eax
    leave
    ret