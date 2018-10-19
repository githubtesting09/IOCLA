#include <stdio.h>

#define MAX_N 1000000

int v[MAX_N];

int main() {
    int n, i = 0, j;

    scanf("%d", &n);

    read_vect:
    if (i < n) {
        scanf("%d", v + i);
        ++i;

        goto read_vect;
    }

    i = 0;

    first_for:
    if (i < n - 1) {
        j = 0;

        second_for:
        if (j < n - i - 1) {
            if (v[j] > v[j + 1]) {
                v[j] = v[j] ^ v[j + 1];
                v[j + 1] = v[j + 1] ^ v[j];
                v[j] = v[j] ^ v[j + 1];
            }

            ++j;
            goto second_for;
        }

        ++i;
        goto first_for;
    }

    i = 0;

    print_for:
    if (i < n) {
        printf("%d ", v[i]);

        ++i;
        goto print_for;
    }

    return 0;
}