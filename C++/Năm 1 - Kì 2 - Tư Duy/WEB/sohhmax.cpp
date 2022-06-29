#include <iostream>
using namespace std;
int main()
{
	int a, b=0, n, i;
	cin>>a;
	for ( i=a-1; i>0; i=i-1){
	b=0;
	 for (n=1; n<i; n++){
		if (i%n==0)
			b=b+n;}
	if (i==b){
		cout<<i; break;}
}
}
