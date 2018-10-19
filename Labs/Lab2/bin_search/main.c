#include <stdio.h>

#define MAX_N 1000000

int v[MAX_N];
int main() {
    int n, i = 0, j, left = 0, right, mid, sol = -1, target;

    scanf("%d %d", &n, &target);

    read_data:
    if (i < n) {
        scanf("%d", v + i);

        ++i;
        goto read_data;
    }

    right = n;

    bin_search:
    if (left <= right) {
        mid = (left + right) / 2;

        if (v[mid] == target) {
            sol = mid;
        } else {
            if (v[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }

            goto bin_search;
        }
    }

    if (sol != -1) {
        printf("%d\n", sol);
    } else {
        printf("ERROR 404: Not found!\n");
    }

    return 0;
}