#include <iostream>
#include <math.h>
using namespace std;
int main(){
    int n,dem1,dem0,m;
    cin>>n;
    m=1;
    dem1=0;
    dem0=0;
    int number[n];
	for(int i=0;i<n;i++){
	int a;
	cin>>a;
	number[i]=a;}

    bool check=false;
    for(int i=0;i<n;i++)
    {
        if (number[i] !=1 && number[i] != 0)
        check=true;
    }
    if ( check==true)
    {
        for(int i=0;i<n;i++)
        {
            if (number[i] !=1 && number[i] != 0){m=m*number[i];}
            if (number[i]==1){dem1++;}
            if (number[i]==0){dem0=0;}    
        }cout<<m+dem1+dem0;
    } 
    if (check==false)    
    {
        for(int i=0;i<n;i++)
        {
            if (number[i]==1){dem1++;}
            if (number[i]==0){dem0=0;}    
        } cout<<dem1+dem0;
    } 
}