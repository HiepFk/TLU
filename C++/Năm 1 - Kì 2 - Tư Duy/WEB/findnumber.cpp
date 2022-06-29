#include<iostream>
#include<math.h>
using namespace std;
int check(){
	int n,v ;
	int number[n];
	for (int j=0;j<n;j++)
	{
		if(number[j]==v)
		{
		return true;}
	}
	return false;
}
int main()
{
	int n, v ;
	cin>>n>>v;
	int number[n];
	for(int i=0;i<n;i++){
	int a;
	cin>>a;
	number[i]=a;}
	if (check()==true){cout<<"YeS";}
	if(check()==false){cout<<"nO";}
	
	
}
