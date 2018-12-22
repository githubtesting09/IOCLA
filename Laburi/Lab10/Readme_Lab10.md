# Lab0xA - gestiunea bufferelor

- se analizeaza si se exploateaza brese de securitate de tipul *buffer overflow*

- exemplele sunt atat sub forma de cod sursa *Assembly*, cat si *C* sau fiseire executabile

## 1-data-buffer

- se populeaza un buffer de 64 de elemente cu elemente astfel incat `buffer[i] = i + 1`, dupa care, aceste valori se afiseaza.

## 2-3-4-stack-buffer

- se modifica o variabila declarata pe stiva din `0xCAFEBABE` in `0xDEADBEEF`;

- tot pe stiva, dupa aceasta variabila, se initializeaza un vector dr `64` de bytes;

- se afiseaza `76` bytes din stiva (**memory disclosure**), corespunzatori:

    - cei `64` de bytes din buffer;

    - `4` bytes: variabila modificata;

    - `4` bytes: `saved_ebp` din `main` (fiind in `main`, acesta este `0`);

    - `4` bytes: valori aleatoare de pe stiva.

## 5-6-read-stdin

- vulnerabilitate evidentiata: funcita `gets`;

- codul *Assembly* este similar cu cel de la exercitiul anterior;

- se va da programului un input de `68` bytes (din fisierul `payload`), facand overflow buffer-ului ce are o capacitate de `64` octeti;

- astfel, se ajunge sa se modifice variabila de mai sus din `0xCAFEBABE` in `0x574F4C46` (*ASCII:* `FLOW`).

## 7-read-stdin-fgets

- vulnerabilitate evidentiata: funcita `fgets`, cu o dimensiune gresita a buffer-ului;

- codul *Assembly* este similar cu cel de la exercitiul anterior;

- `payload`-ul este acelasi ca la exercitiul anterior, dar dimensiunea buffer-ului specificata functiei `fgets` este `69` octeti, pe cand cea reala este de `64` de octeti;

- astfel, se va realiza aceeasi modificare a variabilei `0xCAFEBABE`.

## 8-c-buffer-overflow

- vulnerabilitati evidentiate: funcita `fgets`, cu o dimensiune gresita a buffer-ului + accesul la codu *Assembly* generat un urma compilarii unui program *C*;

- avand un buffer de `64` de octeti, `fgets` se apeleaza cu diemensiunea de `128`;

- din codul *Assemblly* (liniile `32` - `50`) se deduce dimensiunea payload-ului: `78` octeti.

## 9-overflow-in-binary

- vulnerabilitate evidentiata: buffer declarat local (pe stiva), cu o domensiune mai mica decat cea maxima a string-ului ce va ajunge in el;

- folosind `objdump` se ajunge la codul *Assembly*;

- se ajunge in functia success printr-un payload ce modifica in mod convenabil `ebp - 12`.
