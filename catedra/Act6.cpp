#include <iostream>
using namespace std;

int suma( int $a, int $b ){
	int $result;
	__asm__ __volatile__(
			"movl %1, %%eax;"
			"movl %2, %%ebx;"
			"addl %%ebx,%%eax;"		
			"movl %%eax, %0;" : "=g" ( $result ) : "g" ( $a ), "g" ( $b ));
	return $result ;
}

int resta( int $a, int $b ){
	int $result;
	__asm__ __volatile__(
			"movl %1, %%eax;"
			"movl %2, %%ebx;"
			"subl %%ebx,%%eax;"		
			"movl %%eax, %0;" : "=g" ( $result ) : "g" ( $a ), "g" ( $b ));
	return $result ;
}

int gcd( int $a, int $b )
{
	int $result;
	__asm__ __volatile__(
			"movl %1, %%eax;"
			"movl %2, %%ebx;"
	"CONTD: cmpl $0, %%ebx;"
			"je DONE;"
			"xorl %%edx, %%edx;"
			"idivl %%ebx;"
			"movl %%ebx, %%eax;"
			"movl %%edx, %%ebx;"
			"jmp CONTD;"
	"DONE:	movl %%eax, %0;" : "=g" ( $result ) : "g" ( $a ), "g" ( $b ));
	return $result ;
}

//Nueva funcion
int producto(int a, int b, int c){
    int result;
    __asm__ __volatile__(
        "movl %1, %%eax;"
        "imull %2, %%eax;"
        "imull %3, %%eax;"
        "movl %%eax, %0;"
        : "=g" (result)
        : "g" (a), "g" (b), "g" (c)
        : "%eax"
    );
    return result;
}

int sub(int x, int y){
    return x - y;
}



int main(int argc, char** argv) {
	int a,b,c,d;
	cout<<"\nDigite el numero a: ";
	cin>>a;
	cout<<"\nDigite el numero b: ";
	cin>>b;
	cout<<"\nDigite el numero c: ";
	cin>>c;
	d=suma(a,b);
	cout<<"\nEl resultado de la suma de "<<a<<"+"<<b<<"="<<d<<"\n";
	d=resta(a,b);
	cout<<"\nEl resultado de la resta de "<<a<<"-"<<b<<"="<<d<<"\n";
	d=gcd(a,b);
	cout<<"\nEl resultado GCD("<<a<<","<<b<<")="<<d<<"\n";
	d=producto(a,b,c);
	cout<<"\nEl resultado de la multiplicacion de "<<a<<"*"<<b<<"*"<<c<<"="<<d<<"\n";
	
    asm("subl %%ebx, %%eax;"
        "movl %%eax, %%ecx;"
        : "=c"  (c)
        : "a"   (a), "b" (b)
        :                   /* lista clobber vacia */
    );
    
    printf("a = %d\nb = %d\nc = %d\n", a, b, c);
    
    asm("addl %%ebx, %%eax;"
        "movl %%eax, %%ecx;"
        : "=c"  (c)
        : "a"   (a), "b" (b)
        :                   /* lista clobber vacia */
    );

    printf("a = %d\nb = %d\nc = %d\n", a, b, c);
    /*La lista clobber es una lista de cadenas separadas por comas. 
	Cada cadena es el nombre de un registro que el código ensamblador 
	modifica potencialmente, pero para el cual el valor 
	final no es importante. */
	system("pause");

	return 0;
}