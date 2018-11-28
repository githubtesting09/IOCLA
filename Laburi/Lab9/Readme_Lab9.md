# Lab 9

- combinarea *C*-ului cu *Assembly* si invers;

- accet pus pe apeluri de functii si, deci, stiva

## 1-inline-for

- tutorial de inline `for` in Assembly;

- `: "=r"` -> output;

- `: "r"` -> input;

- `"eax", ...` -> registrii utilizati.

- despre alte [constrangeri](https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html#Simple-Constraints).

## 2-inline-rotate

- rotiri stanga si dreapta pe biti in *C*, folosind inline *Assembly*: `ror`, `rol`.

## 3-inline-cpuid

- utilizarea mnemonicii `cpuid` in in *C*, folosind inline *Assembly*;

- outputul este plasat in ordine in registrele `ebx`, `edx`, `ecx`;

- despre [cpuid](https://wiki.osdev.org/CPUID).

## 4-5-max-c-calls

- se apeleaza din *C* functia `get_max`, definita `global` in Assembly;

- parametri (in ordinea aparitiei pe stiva):
	- pointer la vector;

	- lungimea vectorului;

	- adresa variabilei ce stocheaza pozitia maximului.

## 6-7-max-assembly-calls

- exercitiul anterior, pe dos: functia `get_max` este definita in *C*, iar `main`-ul este scris in *Assembly*.

## 8-max-c-calls-x64

- exercitiul `5`, care acum foloseste *Assembly x86_64*;

- parametrii functiei nu mai sunt pe stiva, ci (in ordine) in:

	- `rdi`;

	- `rsi`;

	- `rdx`;

- despre [calling conventions in Assembly x86_64](https://en.wikipedia.org/wiki/X86_calling_conventions#System_V_AMD64_ABI).

## 9-max-assembly-calls

- - exercitiul `7`, care acum foloseste *Assembly x86_64*;

- **Atentie la Makefile!**: executabilul trebuie compilat cu flag-ul `-no-pie` (linker voodoo, idk...).
