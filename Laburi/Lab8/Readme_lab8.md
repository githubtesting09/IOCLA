# Lab8

- sintaxa si utilizarea functiilor in Assembly x86;

- laboratorul este bazat pe [cel anterior](https://github.com/teodutu/IOCLA/tree/master/Laburi/Lab7), despre stiva;

## 0-fibo

- se calculeaza si se afiseaza primii `NUM_FIBO` (in cazul de fata, 10) termeni fibonaci;

- pentru calcul, se utilizeaza stiva sistemului, unde sunt retinuti termenii calculati;

## 1-hello-world

- exemplu apelare `puts`, irelevant

## 2-test

- exemplu de utilizare `objdump`, similar cu cele din [laboratorul 6](https://ocw.cs.pub.ro/courses/iocla/laboratoare/laborator-06);

## 3-print-string

- exemplu de apelare a functiei `puts`, declarata ca fiind `extern`;

## 4-5-reverse-string

- se calculeaza lungimea unui string, iar rezultatul se retine in `eax`;

- se apeleaza functia `reverse_string`;

- functia primeste ca parametri:
	- stringul original (`store_string`);
	- lungimea stringului (stocata in `eax`) si adresa acestuia;
	- stringul-destinatie (`mystring`);

## 6-toupper

- implementare simplificata a functiei `toupper` din `ctype.h`

- se vor transforma in majuscule **doar minusculele** din stringul primit ca parametru;

## bonus-rot13

- `rot13.asm` aplica [rot13](https://en.wikipedia.org/wiki/ROT13) unui string format din minuscule si spatii;

- `rot13++.asm` aplica [rot13](https://en.wikipedia.org/wiki/ROT13) unui numar oricat de mare de string-uri formate din minuscule si spatii, pana cand se depaseste zona de memorie alocata acestora
