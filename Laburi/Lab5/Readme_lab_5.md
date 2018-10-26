# Lab 5

- operatii pe vectori si structuri;

- accent pus pe mnemonici destinate prelucrarii de vectori / stringuri:
  - `rep`;
  - `scas`;
  - `movs`;
  - `cmps`;
  - `cld` / `std`;
  - `lea`;
  
## 1-memset

- `memset(string, char, LENGTH)` implementat in Assembly;

- utilizare `rep` + `stosb`;

## 2-3-strings

- `strlen(string)`;

- numarul de aparitii ale lui `char` (in cazul de fata, 'i') in `string`;

- utilizare `repne` + `scas`;

## 4-5-print-structure

- modificarea campurilor dintr-o structura declarata folosind sintaxa `NASM`;

## 6-process-structure

- crearea unui camp intr-o structura folosind parti din celelalte campuri ale acestei structuri;

- utilizare `rep` + `movs`;

## 7-find-substring

- afisarea tuturor aparitiilor unui substring intr-un string;

- complexitate: `O(mn)`, cu m = lungimea substringului si n = lungimea stringului (implementarea in `O(m + n)` ce foloseste KMP e [aici](https://github.com/teodutu/IOCLA/blob/master/Snippeturi/find_substring_KMP.asm) si urmeaza modelul [acesta](https://github.com/teodutu/IOCLA/blob/master/Laburi/Lab2/KMP_goto/main.c));

- utilizare `rep` + `cmps`.
