#include<iostream>
#include<string.h>
using namespace std;

string a[3];
bool check( string s);
void dm(){
        string s, n ;
        cin>>n;
        a[0]=a[1];
        a[1]=a[2];
        a[2]=n;
        s=a[0]+a[1]+a[2];
        cout<<s<<endl;
        check(s);
    
}
bool check(string s)
{
    if(s=="tlu"){return true;}
    else{return false;}
}
int main(){
    string s;
    for(int i=0;i<3;i++)
    {
        string x;
        cin>>x;
        a[i]=x;
    }
    s=a[0]+a[1]+a[2];
    cout<<s<<endl;
    while(1)
    {
        if(check(s)==true){break;}
        else{dm();if(check(s)==true){break;}}
        //h004_gftth_huandh5
    }
}