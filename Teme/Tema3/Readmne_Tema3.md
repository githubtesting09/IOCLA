# Tema 3 - IOCLA

## Functiile din binarul dat

### mystery1

- functia calculeaza lungimea sirului de input

- `@string`: adresa de inceput a sirului

- `@return`: lungimea sirului

Sirul dat este parcurs octet cu octet, pana se gaseste `\0`, adica `0x0`, iar concomitent, la fiecare nou octet nenul este incrementat un contor ce porneste de la 0, contor ce la gasirea lui `\0` va contine lungimea sirului.

Asadar, este necesar ca sirul de input sa se termine cu `\0`. Altfel, se vor
citi octeti in afara spatiului de memorie si la un moment dat va rezulta un
*segmentation fault*.

- prototip: `int length(char *string)`


### mystery2

- functia gaseste pozitia intr-un sir dat ca parametru a unui caracter primit tot ca parametru

- `@string`: adresa de inceput a sirului
- `@c`: caracterul cautat

Initial, se calculeaza lungimea sirului dat ca parametru prin apelarea functiei
`mystery1`. Deci, daca sirul nu se termina cu un `\0`, se va obtine tot un
*segmentation fault*.

Apoi, se compara fiecare octet din sirul de input cu caracterul primit ca
parametru pana se gaseste un octet identic cu acesta, iar la fiecare nou octet
se creste un contor.

In cazul in care se gaseste caracterul cautat, se verifica
daca lungimea sirului, calculata anterior, nu este 0, iar in caz contrar se
returneaza pozita lui c in sir. Daca, in schimb, sirul este vid (are lungime 0),
se returneaza -1.

Un bug al acestei functii este acela ca daca se cauta un caracter inexistent,
se va depasi dimensiunea sirului din input, dupa care ori se va produce un
segmentation fault, ori se va gasi un 0x0 in afara sirului si se va returna o
pozitie falsa a caracterului in sir.

- prototip: `int find_char(char *string, char c)`


### mystery3

- functia compara primii n octeti din 2 siruri si returneaza 1 daca subsirurile formate din acesti n octeti difera si 0 daca nu

- `@string1`: adresa de inceput a primului sir

- `@string2`: adresa de inceput a celui de-al doilea sir

- `@n`: numarul de caractere verificate

Se compara primii n octeti din sirurile date, unul cate unul. Daca se gaseste o
pereche de caractere diferite, se returneaza 1, altfel 0.

O vulnerabilitate a functiei apare in cazul in care sirurile au aceeasi lungime,
iar n este mai mare decat aceasta. In aceasta situatie, caracterele terminale
`\0` vor fi identice, dupa care se vor verifica octeti din afara sirurilor, ceea
ce va rezulta ori intr-un segmentation fault, ori intr-o valoare de return
nesemnificativa (undefined behaviour).

Daca, in schimb, sirurile au lungimi diferite, iar cel putin cel mai scurt nu
are `\0` la final, vom avea un alt segmentation fault sau un undefined behaviour
dat de faptul ca se compara caractere din afara sirului mai scurt cu cele din
sirul mai lung.

- prototip: `bool compare_strings(char *string1, char *string2, int n)`


### mystery4

- copiaza primele n caractere dintr-un sir dat ca parametru in altul primit tot ca parametru

- `@string1`: adresa de inceput a sirului in care se copiaza

- `@string2`: adresa de inceput a sirului din care se copiaza

- `@n`: numarul de caractere copiate

Se va repeta de n ori operatia de copiere a unui caracter din sirul 2 in sirul 1.

Vulnerabilitatea acestei functii consta in posibilitatea ca n sa fie mai mare
decat dimensiunea unuia dintre siruri. Pe langa posibilitatea aparitiei unui
*segmentation fault*, mai exista 2 riscuri de corupere a datelor, dupa cum urmeaza:

Daca `n > strlen(string2)`, atunci se vor copia in sirul 1, octeti din alte
variabile, ce sunt pozitionate in continuarea sirului 2 in memorie.

Daca `n > strlen(string1)`, se vor modifica si octeti din afara sirului 1, care
fac parte din alte variabile.

Ambele situatii reprezinta cazuri de undefined behaviour.

- prototip: `void copy_string(char *string1, char *string2, int n)`


### mystery5

- verifica daca un caracter reprezinta o cifra *ASCII* sau nu

- `@c`: caracterul verificat

Caracterul primit ca input este comparat cu `0x30` (`0` *ASCII*) si cu `0x39` (`9` *ASCII*). Daca respectivul caracter este in acest interval inchis, se returneaza 1, iar daca nu, 0.

In forma in care este scris codul Assembly, insa, se pare ca functia poate primi
ca parametru si un numar pe 32 de biti, din care se va analiza doar primul byte
(dupa regula stabilita de *little endian*).

- prototip: `int isdigt(char c)`


### mystery6

- formeaza "rasturnatul" unui sir primit ca input

- `@string`: adresa de inceput a sirului ce va fi procesat

Initial se calculeaza lungimea sirului dat prin intermediul functiei mystery1 si
se rezerva pe stiva in stack frame-ul functiei un numar de octeti egal cu
aceasta lungime.

Apoi, se copiaza sirul primit ca input in acest nou sir declarat pe stiva, dar
in ordine inversa. urmand ca mai apoi sa se copieze ce se afla pe stiva inapoi
in sirul primit ca parametru, prin intermediul functiei `mystery4`

- prototip: `void reverse_string(char *string)`


### Mystery7

- returneaza numarul format din caracterele unui sir sau -1, daca printre aceste caractere se gasesc si unele care nu sunt cifre ASCII

- `@string`: adresa de inceput a sirului care va fi transformat in numar

- `@return`: numarul obtinut

Se declara pe stiva un numar pe 32 de biti in care se va stoca numarul format.

Se calculeaza lungimea sirului dat ca parametru prin functia mystery1, dupa care
acesta se inverseaza folosind `mystery6`.

Sirul inversat este parcurs octet cu octet de la final la inceput.

Fiecare octet este verificat sa fie o cifra *ASCII* cu ajutorul functiei `mystery5`.

Daca nu este, se returneaza -1, iar daca da, se scade din acest caracter `0x30`
(`'0'` *ASCII*), pentru a se converti intr-o cifra reala.

In acest punct, se inmulteste numarul obtinut pana acum cu 10 (`0xa`), dupa care
acestui numar i se adauga cifra reprezentata de caracterul curent, iar numarul
ce rezulta este scris inapoi in memorie.

Procedura de mai sus se repeta de un numar de ori egal cu lungimea sirului dat.

Vulnerabilitatile functiei le includ pe cele ale functiilor apelate de aceasta:
`mystery6`, `mystery5`, `mystery1`, dar si faptul ca daca numarul continut in sirul
de input depaseste 32 de biti, in urma calculelor, rezultatul va fi incorect,
din cauza *overflow*-ului.

- prototip: `int make_number(char *string)`


### mystery8

- cauta un subsir intr-un sir si returneaza 1 daca il gaseste si 0 daca nu

- `@string`: adresa de inceput a sirului in care se cauta

- `@substring`: adresa de inceput a subsirului care se cauta

- `@len`: lungimea subsirului

Se declara pe stiva 2 indici initializati cu 0. Fie `i` indicele folosit pentru
iterarea sirului si `j` cel pentru subsir.

Astfel, pana cand i devine egal cu len, se va verifica initial daca `string[j]`
este unul dintre caracterele de final (`'\0'` sau `'\n'`), caz in care se returneaza
0.

Altfel, se disting 2 situatii: daca `string[j] == sibstring[i]`, inseamna ca s-a
gasit un caracter identic atat in sir, cat si in subsir. In acest caz, se
incrementeaza `i` si se continua bucla (se incrementeaza si `j`), pentru a verifica
si celelalte caractere.

In caz contrar, subsirul va fi reluat de la inceput, dar sirul nu. Deci, in
cazul in care exista o suprapunere intre un subsir din sir si cel cautat, atunci
nu se va gasi subsirul cautat, chit ca acesta exista in sir. De exemplu, daca
sirul este `"ababac"`, iar subsirul este `"abac"`, acesta clar exista in sir, dar
in momentul in care `i` si `j` vor fi 3, `'c' != 'b'`, `i` va redeveni 0, dar nu si `j`,
deci raman de comparat `"bac"` cu `"abac"`, care, evident, nu sunt egale.

- prototip: `int find_substring(char *string, char *substring, int len)`


### mystery9

- cauta un subsir intr-un set de linii, intre o pozitie de start si una de sfarsit dintr-un text si afiseaza liniile complete (care contin si `'\n'` pana la pozitia de final) ce contin subsirul

- `@string`: adresa de inceput a sirului ce contine toate liniile, separate prin `'\n'`

- `@start`: pozitia de start in sirul dat

- `@end`: pozitia de final in sir

- `@substring`: adresa de inceput a subsirului cautat

Se declara pe stiva 2 indici: unul pentru iterarea sirului si altul care va
retine pozitiile inceputurilor de linie din sirul de input. Fie acesti indecsi
`i` si `j`, pentru a putea face referire la ei.

Pe deasupra, tot pe stiva se va stoca lungimea subsirului calculata prin functia
`mystery1`.

Atat `i` si `j` pornesc de la start. `i` creste cu 1, parcurgand intregul sir pana la
end, iar cand se gaseste un `'\n'` la `string[i]`, se apeleaza `mystery8(string + j, substring, lungime_substring)`.

Daca functia returneaza 0 (s-a gasit subsirul), atunci se afiseaza linia curenta
prin functia `print_line(string + j)`. In caz contrar, `j` devine primul caracter de
pe urmatoarea pozitie din sir, deci urmatoarea pozitie de dupa `'\n'`, adica `i + 1`.

Vulnerabilitatea functiei este posibilitatea ca end sa fie o pozitie din afara
sirului, ceea ce ar duce la un *undefined behaviour* sau la un *segmentation fault*.

Pe langa aceasta, functia `mystery9` are aceleasi vulnerabilitati ca si cele 2
functii apelate de aceasta: `mystery1` si `mystery8`.

- prototip: `void find_substring_on_lines(char *string, int start, int end, char *substring)`


## Descrierea progamului

Programul functioneaza in doua moduri:

In lipsa argumentelor, citeste un sir de la tastatura, pe care il afiseaza.

Daca are argumente, este similar unui fgrep: afiseaza la stdout liniile ce
contin un subsir dat ca parametru in linia de comanda dintr-un fisier primit tot
din linia de comanda. Spre deosebire de fgrep, programului dat i se pot oferi si
anumite limite inferioare sau superioare (pozitii in fisier) intre care sa caute.

In absenta limitelor, acestea se considera inceputul fisierului, respectiv
finalul acestuia.

### Argumente

- `-i INPUT_FILE`: numele fisierului din care se selecteaza liniile

- `-f STRING`: subsirul care se cauta in fisier

- `-s START`: pozitia de start in fisier

- `-e END`:	pozitia de sfarsit in fisier

Sirurile `STRING` si `INPUT_FILE` pot avea maximum 31 de caractere.

Daca `END` > numarul de octeti din `FILE`, se cauta pana la finalul fisierului.

Daca argumentele se repeta, programul se termina.

Argumentele se pot da in orice ordine.

Dimensiunea maxima a lui `INPUT_FILE` este de **114753536** octeti, deoarece aceasta este
dimensiunea sirului din binarul dat in care se va retine textul din fisier.

### Coduri de iesire

- 0: executie cu succes

- 249: nu s-a putut deschide fisierul de intrare

- 251: numerele date pentru `-s` sau `-e` nu sunt valide (contin caractere diferite de cifrele ASCII)

- 252: `STRING` sau `INPUT_FILE` au mai mult de 31 de caractere

- 253: cel putin un argument se repeta

- 254: alte argumente decat `-i`, `-f`, `-s`, `-e`



## Optimizari

1. Optimizare de viteza:

Functiile `mystery5`, `mystery6` si `mystery8` nu sunt apelate decat intern, de alte
functii `mystery` si sunt apelate ineficient, deci vor fi eliminate.

### mystery1

In binarul dat se folosesc 2 registre: unul pentru a retine sirul si celalalt
pentru a numara octetii intalniti pana la `'\0'`.

Optimizarea presupune folosirea unui singur registru care va retine cate o
adresa din sir si care va fi incrementat cu 1 la fiecare pas, pana cand octetul
la care acesta "pointeaza" este 0. Apoi, se va scadea adresa initiala din cea
finala obtinuta in acest registru, rezultatul fiind chiar lungimea sirului.

### mystery2

Nu mai este nevoie de aflarea lungimii sirului dat ca parametru, ci se va merge
din octet in octet si se va compara la fiecare pas octetul curent cu caracterul
cautat (retinut si el intr-un registru).

Aceasta bucla continua pana cand se gaseste `'\0'`, caz in care caracterul cautat
nu se afla in sir si, deci, se returneaza -1.

Daca, in schimb, acest caracter se gaseste, se scade din adresa curenta adresa
initiala pentru a se determina pozita in sir la care respectivul caracter se
afla.

### mystery3

Se va folosi un singur registru pentru a retine pozita in sirurile date, care
va fi decrementat la fiecare pas al compararii pana ajunge la 0, caz in care
sirurile sunt egale. Din acest motiv, sirurile se compara invers, de la final
la inceput.

### mystery4

Se foloseste un registru pentru iterarea sirurilor de la final la inceput, exact
ca in mystery3. "Transferul" unui octet dintr-un sir in altul se face prin
intermediul unui singur registru. 


### mystery7

Numarul se formeaza in `eax`, dupa formula `eax = eax * 10 + cifra_curenta`.

Inmultirea se face prin intermediul unui nou registru, iar cifra curenta se
calculeaza scazand `0x30` (`'0'` *ASCII*) din fiecare octet gasit in sirul de input.

Pentru a testa daca acest octet este in intervalul `['0', '9']`, adica `[0x30, 0x39]`,
se va efectua scaderea lui `0x30`, dupa care se va verifica SF, a carui activare
indica o valoare mai mica decat '0', dupa care rezultatul scaderii se compara cu
9.

Daca sirul dat reprezinta un numar, acest numar se va calcula dupa formula de
mai sus.

### mystery9

Functia pastreaza greseala din binarul original, deoarece aceasta greseala
permite ca algoritmul sa aiba complexitatea `O(strlen(sir))`, unde "sir" este
sirul in care se face cautarea.

De asemenea, afisarea nu se face prin intermediul vreunei functii externe, ci
direct prin apelul de sistem corespunzator.

Astfel, se pastreaza intr-un registru ultima adresa din sir ce trebuie
verificata, iar adresa curenta se compara mereu cu aceasta pana cand ajung egale,
caz in care functia se termina. Tot intr-un registru se pastreaza si adresa
de inceput a subsirului. S-au ales aceste 2 valori, deoarece ele sunt cele mai
folosite (dintre valorile care puteau fi pastrate), ceea ce face ca eliminarea
accesului la memorie atunci cand este nevoie de aceste valori sa fie cea mai
"profitabila" ca timp de executie.

Se retine pe stiva adresa de inceput a fiecarei linii, de la care se va face
afisarea in momentul in care subsirul este gasit. De asemenea, mai este nevoie
tot pe stiva de o variabila auxiliara, pentru a salva un registru inainte de
afisare.

Compararea sirului cu subsirul se va face inline, octet cu octet.

Daca iterarea subsirului ajunge la `'\0'`, acest subsir s-a gasit pe linia
curenta, care urmeaza sa fie afisata. Inainte de acest lucru, se cauta tot
inline urmatorul `'\n'`, iar daca acesta se afla in afara sirului (la o adresa mai
mare decat cea de final) sau nu exista, algoritmul se incheie.

Daca pozitia lui `'\n'` este in interiorul sirului verificat, se face afisarea,
iar cautarea se reia de pe linia urmatoare, adica de pe `pozitie_newline + 1`.


2. Optimizare de dimensiune:

Din aceleasi motive ca la optimizarea pentru viteza, se elimina functiile
`mystery5`, `mystery6` si `mystery8`. Ca regula generala, se va cauta ca buclele sa
fie de tipul hardware oricat de des se poate.

De asemenea, doar functia `mystery9` foloseste variabile locale. Din acest motiv,
nu este necesara crearea unui nou stack frame in celelalte, astfel reducand
dimensiunea binarului rezultat.

### mystery1

Folosind scasb cu numar maxim de pasi -1, se compara valoarea din `al`, care prin
`xor` se seteaza pe 0, cu fiecare valoare din sirul de input pana cand se  gaseste
o valoare diferita. Lungimea va fi adresa finala din acest `sir - 1 - adresa_nitiala`.

### mystery2

Nestiind lungimea inputului si neputand-o calcula in prealabil deoarece acest
lucru ar creste foarte mult complexitatea, ingreunand functionarea *checker*-ului,
aceasta functie se trateaza similar cu omonima sa din `skel_speed`, doar ca nu
se mai retine caracterul primit ca parametru intr-un registru, deoarece acest
lucru ar necesita o instructiune in plus.

In cazul in care nu se gaseste caracterul cautat, valoarea de return nu este
pusa in `eax` ca un imediat, ci se creeaza dupa formula `eax = ~(eax ^ eax)`.

### mystery3

Se foloseste cmpsb pentru compararea sirurilor, iar daca la finalul repetarilor
`ecx` este 0, inseamna ca sirurile sunt egale, iar in caz diferit nu. Valoarea de
return se calculeaza intr-un mod similar cu `mystery2`.

### mystery4

Mnemonica specifica acestei functii este `movsb`, care se apeleaza pentru sirurile
date si pentru numarul de pasi primit ca parametru.

### mystery7

Nu se calculeaza lungimea sirului, deoarece apelul functiei ar fi costisitor (5
octeti), la acesta adaugandu-se si loopul si punerea parametrului functiei
pe stiva. Asadar, se va proceda intr-un mod similar cu omonima din `skel_speed`,
cu precizarea ca aici se foloseste `mul` in loc de `imul`, deoarece ocupa mai putini
octeti (2 fata de 3).

Si de aceasta data, in eax se va scrie -1 in modul folosit la `mystery2`, in cazul
in care sirul dat nu contine doar cifre.

### mystery9

Si de data aceasta s-a pastrat greseala din binarul dat, pentru a reduce numarul
de instuctiuni.

Pentru a reduce accesul la memorie, care ar insemna instructiuni mai mari,
adresa de inceput si cea de final a sirului sunt retinute in registre. Pe stiva
se va retine doar lungimea subsirului.

Inainte de a se cauta subsirul, se verifica existenta `newline`-ului, prin
`mystery2`. Daca acesta se afla la o pozitie ce depaseste adresa de final impusa
de parametrii functiei, aceasta se termina.

Compararea se face inline, prin `cmpsb`. Daca se gaseste subsirul pe o linie,
aceasta se afiseaza cu print_line si se trece la urmatoarea. Daca nu, se
continua cautarea la pozitiile urmatoare de pe linie.
