%include "io.inc"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
substring: db "BABC", 0

substr_length: dd 4
print_format: db "Substring found at index: ", 0

section .bss
source_length: resd 1
pref_array: resd 10

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp, esp

    ; TODO: Fill source_length with the length of the source_text string.
    ; Find the length of the string using scasb.
    mov al, 0  ; \0
    mov edi, source_text
    
    repne scasb
    
    sub edi, source_text + 1
    mov [source_length], edi
    mov byte [pref_array], 0
   
    mov eax, 1
    xor ebx, ebx
    xor dl, dl
    
build_pref_array:
    cmp eax, [substr_length]
    je make_KMP
    
back_pref_array:
    mov dl, byte [substring + eax]
    cmp dl, byte [substring + ebx]
    je compare_positions
    cmp ebx, 0
    je compare_positions
    
    mov ebx, [pref_array + (ebx - 1) * 4]
    jmp back_pref_array

compare_positions: 
    cmp dl, byte [substring + ebx]
    jne end_build
    inc ebx
    
end_build:
    mov [pref_array + eax * 4], ebx
    inc eax
    jmp build_pref_array



make_KMP:
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    
KMP_search:
    cmp eax, [source_length]
    jge return
    
back_on_array:
    mov dl, byte [source_text + eax]
    cmp dl, byte [substring + ebx]
    je compare_positions_search
    cmp ebx, 0
    je compare_positions_search
    
    mov ebx, [pref_array + (ebx - 1) * 4]
    jmp back_on_array    
        
compare_positions_search:
    cmp dl, byte [substring + ebx]
    jne end_search
    inc ebx
    
end_search:
    cmp ebx, [substr_length]
    jne back_to_start
    
    mov ecx, eax
    sub ecx, [substr_length]
    inc ecx
    
    PRINT_STRING print_format
    PRINT_UDEC 4, ecx
    NEWLINE
    
    mov ebx, [pref_array + (ebx - 1) * 4]
    
back_to_start:    
    inc eax
    jmp KMP_search
    
return:
    xor eax, eax
    leave
    ret
