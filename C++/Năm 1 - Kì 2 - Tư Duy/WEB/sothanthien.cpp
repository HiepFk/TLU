#include<iostream>
#include<math.h>
using namespace std;
int nghichdao(int i){
	int b=0,d;
	while (i>0){
	d=i%10;
	b=b*10+d;
	i=i/10;	}
return b;
}

int ucln(int i,int x){
    int sodu;
    while (x != 0){sodu = i % x; i = x; x = sodu;}
    return i;
}
int main(){
	int m, n,d=0;
	cin>>m>>n;
	
	for(int i=m;i<n;i++)
	{int x=nghichdao(i);
	 if(ucln(i,x)==1){d=d+1;}
	}
	
	
	cout<<d;
}
