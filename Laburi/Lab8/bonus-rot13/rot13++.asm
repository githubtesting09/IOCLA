%include "io.inc"

section .data
    string db "ana", 0, "are", 0, "mere", 0
    format db "%s %s %s", 10, 0

section .text
global CMAIN

rot13:
    push ebp
    lea ebp, [esp]
    
    xor ebx, ebx
    mov ecx, [ebp + 8]
rot13_on_a_char:
    mov bl, [ecx]
    
    cmp ecx, format
    je return
    cmp bl, 0
    je next_char
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
    
    lea eax, [string + 8]
    push eax
    lea eax, [string + 4]
    push eax
    push string
    push format
    call printf
    
    lea esp, [ebp]
    xor eax, eax
    leave
    ret