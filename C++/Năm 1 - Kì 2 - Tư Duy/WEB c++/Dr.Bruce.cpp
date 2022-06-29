#include <string>
#include <string.h>
#include <iostream>
using namespace std;
int main()
{
    int n ;
    cin>>n;
    string hate = "I hate";
    string love = "I love";
    string that = " that ";
    string it = " it";
    string s="";
    for( int i=0;i<n;i++)
    {
        if(i%2==0)
        {s=s+ hate;}
        else{s=s+love;}
        if(i<(n-1)){
            s=s+that;
        }
    }
    s=s+it;
    cout<<s;
    return 0;
}