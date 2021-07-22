#include <stdio.h>
/*
iorga cristian grupa 914
               /\_[]_/\
              |] _||_ [|
       ___     \/ || \/
      /___\       ||
     (|0 0|)      ||
   __/{\u/}\_ ___/vvv
  / \  {~}   / _|_p|
  | /\  ~   /_/   []
  |_| (____)
  \_]/______\
     _\_||_/_
    (_,_||_,_)
*/

int assembler_maximum(int array[], int len);

int main()
{
    int intel, i = 0, stop = 0, len = 1000, array[1000], max;
    printf("Input string: ");
    while (i < len){
        scanf ("%d", &intel);
        if (intel == stop)
            break;
        array[i] = intel;
        i++;
    }
    if (i == 0)
        goto finish;
    
    max = assembler_maximum(array, i);    
    FILE *f = fopen("C:\\Users\\origi\\Desktop\\Lab12\\max.txt", "w");
    if (f == NULL)
        goto finish;
    
    fprintf(f, "Max int is: %x", max);  
    fclose(f);
    finish:
        printf("\n");
    
    //return 0;
}