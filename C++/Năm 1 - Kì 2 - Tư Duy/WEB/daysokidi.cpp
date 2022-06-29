#include <iostream>
#include <string>
using namespace std;

int check(int n )
{
	if (n%2==0){n=n/2;}
	if (n%2!=0){n=n*3+1;}
	return n;
}


int main()
{
	int n, i;
	cin>>n;
	int a[5000];
	while (n!=0)
	{
	for (int i=0;i++;)
	{
	a[i]=check(n);
	}
	if (check(n)==1){break;}
	}
	cout<<i;
}
