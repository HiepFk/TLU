#include<iostream>
using namespace std;
int check(int a,int b,int c)
{
if ( (a>b && b>c)||(b>a&&b<c)){
	return b;}
if ( (a>c && c>b)||(c>a&&c<b)){
	return c;}
if ((b>a && a>c)||(a>b&&a<c)){
	return a;}
}
int main(){
    int n;
    cin>>n;
    int s[n];
    for(int i=0;i<n;i++){
        int a, b, c;
        cin>>a>>b>>c;
        s[i]=check(a,b,c);
                        }
    for (int i=0;i<n;i++)
    {
        cout<<"Case "<< i+1<<": "<<s[i]<<endl;
    }
}

