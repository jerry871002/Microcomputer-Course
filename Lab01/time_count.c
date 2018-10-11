#include <stdio.h>

int count = 0;

int main() {
    for (int i = 0; i < 256; i++) {
        for (int j = 0; j < 256; j++) {
            for (int k = 0; k < 256; k++) {
                count++;
                /*if ((2+(2+(2+(4*255)+4)*j+4)*i+4) < 6000000)
                    break;
                if ((2+(2+(2+(4*0)+4)*j+4)*i+4) > 6000000)
                    goto END;*/
                int clock_num = 2+(2+(2+(4*k)+4)*j+4)*i+4;
                if(clock_num == 6000000) {
                    printf("(R5, R6, R7) = (%d, %d, %d)\n", i, j, k);
                    printf("(R5, R6, R7) = (%#x, %#x, %#x)\n\n", i, j, k);
                    break;
                }
            }
        }
    }
    END:
    printf("%d\n", count);
    return 0;
}
