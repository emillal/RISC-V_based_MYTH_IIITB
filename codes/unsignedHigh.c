#include <stdio.h>
#include <math.h>
int main()
{
    unsigned long long int max = (unsigned long long int)(pow(2,64)-1);     //will display the max number
    //unsigned long long int max = (unsigned long long int)(pow(2,127)-1);  //(out of range) will display the max number(within range)
    //unsigned long long int max = (unsigned long long int)(pow(2,10)-1);   // will display number (since it is within range)
    //unsigned long long int max = (unsigned long long int)(pow(2,64) * -1); // will display 0 since it is a -ve number
    printf("highest number represented by unsigned long long int is %llu\n",max);
    return 0;
}