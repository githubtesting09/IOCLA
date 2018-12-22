# Tema 2 IOCLA

## General:

- definitie(verbul "a xora"): se introduce in limba romana verbul "a xora", ce apartine grupei I de conjugare;

- se va folosi proprietatea [1]: `x ^ a ^ a = x`;

- pentru functiile "interne" ale task-urilor (cele care nu sunt apelate direct din main) s-a preferat in general transmiterea parametrilor prin registre, pentru a se folosi mai putina memorie pe stiva si pentru simplificarea codului;

- urmand sfaturile din *The Art of Assembly Language Programming*, codul este indentat cu 16 spatii (2 taburi de 8),

## Task 1:

- cheia de decriptare se afla dupa primul `\0` din input, adica la `input[strlen(input) + 1]`;

- se vor parcurge byte cu byte atat string-ul criptat cat si cheia pana se va gasi `\0` si se vor xora octetii din string si din cheie intre ei.

## Task 2:

- intrucat string-ul criptat a fost format xorand un octet din cel initial cu succesorul sau, decriptarea se va face invers: se va pleca de la finalul inputlui si va xora fiecare byte (in afara de primul) cu predecesorul sau.

## Task 3:

- se va gasi cheia ca la Task 1;

- se vor forma concomitent cate un byte din string si unul din cheie pe baza cifrelor hexa din input, care apoi se vor xora;

- `string[i]` se va forma din `string[2 * i]` si `string[2 * i + 1]` xorat cu `cheie[2 * i]` si `cheie[2 * i + 1]`.

## Task 4:

- se prelucreaza cate `8` octeti din input, se genereaza valorile corespunzatoare acestora conform criptarii base32, dupa care cei `40` de biti rezultati sunt procesati cate `8` pentru a crea octetii din string-ul initial;

- cei `40` de biti se pastreaza de la `MSB` la `LSB` in perechea `edi:esi`.

## Task 5:

- se parcurg la rand toate valorile posibile ale octetului-cheie (de la `0` la `255`), iar daca in urma xorarii inputului cu aceasta cheie se obtine un string ce contine "force", inseamna ca s-a gasit cheia corecta (`142`);

- daca nu, folosind `[1]`, se recreeaza inputul original, xorand din nou cu cheia curenta.

## Task 6:

- se gaseste cheia ca la Task 1;

- se parcurg octet cu octet atat string-ul criptat, cat si cheia si se xoreaza pentru a se forma string-ul original;

- cand cheia se termina (se gaseste `\0`), se reia de la inceput, fiind preluatadin parametrii functiei.
