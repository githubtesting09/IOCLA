# Tema 1 IOCLA (evaluare de expresie in forma poloneza postfixata)

# Algoritm:

- se citeste de la `stdin` stringul ce contine expresia, iar adresa acestuia se stocheaza in `ecx`;

- se parcurge stringul caracter cu caracter si se efectueaza operatiile gasite sau se formeaza numere, prin intermediul functiei `make_number`;

- aceasta nu primeste parametri, operand cu acelasi registru `ecx` ca si main-ul si returneaza numarul creat fara semn in `eax`;

- nu este nevoie de variabile suplimentare, in afara de stringul pentru input si a stivei, toate operatiile fiind efectuate cu registrele.

# Implementare:

- pentru a se retine numerele citite si rezultatele calculelor s-a folosit stiva sistemului;

- pentru reducerea numarului de instructiuni si a memoriei utilizate, deci din ratiuni de eficienta, se va retine ultimul numar obtinut fie din calcule, fie parsand inputul (caci acest numar este cel des mai folosit), in eax si doar restul rezultatelor pe stiva;

- retinand direct adresele octetilor din input, ecx va creste pana cand valoarea de la adresa acestuia va fi `0`, corespunzatoare terminatorului de sir `\0`.
