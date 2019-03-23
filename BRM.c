//#include "stdlib.h"
extern unsigned long BigReal_Mode();
extern unsigned long ReadMem_32(unsigned long a);
//extern int ENABLEA20(int a);

int main()
{
	unsigned long x; 
	BigReal_Mode();
	x = ReadMem_32(0xE0000000);
	//printf("x=%d",&x);
	printf("x=%x",x);	

	return 0;
}
