#include<iostream>
using  namespace std ;
int main()
{
    int m,n;
    cin>>m>>n;
    int a[n];
    int b[m];
    for ( int i=0;i<n;i++){
        int x;
        cin>>x;
        a[i]=x;
    }
    for(int j=0;j<m;j++){
        int y;
        cin>>y;
        b[j]=y;
    }
    for( int k=0;k<n;k++){
        bool check = false;
        for(int h=0;h<m;h++)
        { 
            if(a[k]==b[h])
            {check==true;break;}
        }
        if(check==true){cout<<"1 ";}
        if(check==false){cout<<"0 ";}
    }
}
