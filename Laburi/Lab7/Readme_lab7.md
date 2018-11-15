# Lab 7 - lucrul cu stiva

- operatii cu stiva unui sistem `x86`;

- `esp`, `ebp`;

- `push`, `pop`;

- inainte de perminarea programului, trbeuie resincronizate baza si varful stivei: `lea esp, [ebp]`

## 0-mean

- se calculeaza media aritmetica a elementelor unui vector;

- rezultatul este afisat atat ca un intreg, cat si ca un numar rational cu 5 zecimale;

## 1-max

- se determina maximul dintr-un vector folosinmd stiva sistemului pentru a stoca maximul la un anumit moment;

- varful stivei se acceseaza prin instructiuni `push` / `pop`;

## 2-reverse

- inversarea unui sir de numere pe 1 octet cu ajutorul stivei;

- parcurgand vectorul, fiecare numar gasit este pus pe stiva;

- la finalul parcurgerii, stiva contine numerele din vector in ordine inversa;

## 3-stack-addressing

- se pun pe stiva numerele de la 1 la 5, urmate de string-ul "Ana are mere\0";

- apoi, se afiseaza continutul stivei de la baza(`ebp`) pana la varf (`esp`);

## 4-local-var

- se face interclasarea a 2 vectori (`array_1` si `array_2`);

- vectorul rezultat se stocheaza pe stiva, fara a mai fi retinur in zona de date;

## 5-gcd

- se calculeaza cmmdc-ul a 2 numere (49 si 28), iar rezultatele intermediare si cel final se retin pe stiva;

- se tine seama de necesitatea egalarii varfului stivei cu baza acesteia la iesirea din program.
