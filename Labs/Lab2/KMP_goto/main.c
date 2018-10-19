#include <stdio.h>
#include <string.h>

#define MAX_STR 2000001
#define MAX_FINDS 1000

FILE *pFileIn, *pFileOut;

int numApp, map[MAX_STR], apps[MAX_FINDS];
char pattern[MAX_STR], str[MAX_STR];

int main() {
    pFileIn = fopen("strmatch.in", "r");
    pFileOut = fopen("strmatch.out", "w");

    fgets(pattern, MAX_STR, pFileIn);
    fgets(str, MAX_STR, pFileIn);

    int lenStr = strlen(str);
    int lenPatt = strlen(pattern) - 1;
    int i, j;

    if (lenPatt > lenStr) {
        fprintf(pFileOut, "0\n");
        goto return_label;
    }

//    for (int i = 1, j = 0; i < lenPatt; ++i) {
//        while (pattern[i] != pattern[j] && j) {
//            j = map[j - 1];
//        }
//
//        if (pattern[i] == pattern[j]) {
//            ++j;
//        }
//
//        map[i] = j;
//    }
    i = 1; j = 0;

    build_prefArray:
    if (i < lenPatt) {

        back_prefArray:
        if (pattern[i] != pattern[j] && j) {
            j = map[j - 1];
            goto back_prefArray;
        }

        if (pattern[i] == pattern[j]) {
            ++j;
        }

        map[i] = j;

        ++i;
        goto build_prefArray;
    }

//    for (int i = 0, j = 0; i < lenStr; ++i) {
//        while (pattern[j] != str[i] && j) {
//            j = map[j - 1];
//        }
//
//        if (str[i] == pattern[j]) {
//            ++j;
//        }
//
//        if (j == lenPatt) {
//            if (++numApp < MAX_FINDS) {
//                apps[numApp] = i - lenPatt + 1;
//            }
//
//            j = map[j - 1];
//        }
//    }

    i = 0; j = 0;

    KMP_search:
    if (i < lenStr) {

        back_on_array:
        if (pattern[j] != str[i] && j) {
            j = map[j - 1];
            goto back_on_array;
        }

        if (str[i] == pattern[j]) {
            ++j;
        }

        if (j == lenPatt) {
            if (++numApp < MAX_FINDS) {
                apps[numApp] = i - lenPatt + 1;
            }

            j = map[j - 1];
        }

        ++i;
        goto KMP_search;
    }

    fprintf(pFileOut, "%d\n", numApp);
    numApp = (numApp > 1000 ? 1000 : numApp);

    i = 1;

    print_matches:
    if (i <= numApp) {
        fprintf(pFileOut, "%d ", apps[i]);
        goto print_matches;
    }
    fprintf(pFileOut, "\n");

    return_label:
    return 0;
}