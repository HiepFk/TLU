#include<math.h>
#include<iostream>
using namespace std;
int main()
{
	int n,m;
	cin>>n>>m;
	int number[n];
	for(int i=0;i<n;i++){
	int a;
	cin>>a;
	number[i]=a;}

    bool check=false;
    for(int i=0;i<n;i++)
    {
        if (number[i]==m)
        check=true;
    }
    if(check==true){cout<<"YeS";}
    else{cout<<"nO";}
}