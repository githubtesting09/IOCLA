%include "io.inc"
section .data
a11 dd 0
a12 dd 1
a21 dd 1
a22 dd 1

b11 dd 1
b12 dd 0
b21 dd 0
b22 dd 1

aux11 dd 0
aux12 dd 0
aux21 dd 0
aux22 dd 0

section .bss
n: resb 4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging

    ;mov eax, 3
    ;mov ebx, 0
    ;mov ecx, n
    ;mov edx, 4
    ;int 0x80
    
    mov ecx, 10   
    mov edx, 0
    
fibonacci:
    test ecx, ecx
    je print
    
    test ecx, 1
    jz a_squared
    
    mov eax, [b11]
    imul eax, [a11]  ; b11 * a11
    mov ebx, [b12]
    imul ebx, [a21]  ; b12 * a21
    add eax, ebx  ; (b11 * a11) + (b12 * a21)
    mov [aux11], eax
    
    mov eax, [b11]
    imul eax, [a12]  ; b11 * a12
    mov ebx, [b12]
    imul ebx, [a22]  ; b12 * a22
    add eax, ebx  ; (b11 * a12) + (b12 * a22)
    mov [aux12], eax
    
    mov eax, [b21]
    imul eax, [a11]  ; b21 * a11
    mov ebx, [b22]
    imul ebx, [a21]  ; b22 * a21
    add eax, ebx  ; (b21 * a11) + (b22 * a21)
    mov [aux21], eax
    
    mov eax, [b21]
    imul eax, [a12]  ; b21 * a12
    mov ebx, [b22]
    imul ebx, [a22]  ; b22 * a22
    add eax, ebx  ; (b21 * a12) + (b22 * a22)
    mov [b22], eax
    
    mov eax, [aux11]
    mov [b11], eax
    mov eax, [aux12]
    mov [b12], eax
    mov eax, [aux21]
    mov [b21], eax  ; b *= a    

a_squared:
    mov eax, [a11]
    imul eax, eax  ; a11 * a11
    mov ebx, [a12]
    imul ebx, [a21]  ; a12 * a21
    add eax, ebx  ; (a11 * a11) + (a12 * a21)
    mov [aux11], eax
    
    mov eax, [a22]
    imul eax, eax  ; a22 * a22
    add eax, ebx  ; (a22 * a22) + (a12 * a21)
    mov [aux22], eax
    
    mov eax, [a11]
    add eax, [a22]  ; a11 + a22
    imul eax, [a12]  ; a12 * (a11 + a22)
    mov [aux12], eax
    
    mov ebx, [a12]
    div ebx  ; a11 + a22
    imul eax, [a21]  ; a21 * (a11 + a22)
    mov [a21], eax
    
    mov eax, [aux11]
    mov [a11], eax
    mov eax, [aux12]
    mov [a12], eax
    mov eax, [aux22]
    mov [a22], eax  ; a *= a
    
    shr ecx, 1
    jmp fibonacci
    
print:
    PRINT_UDEC 4, b11
    
    xor eax, eax
    ret