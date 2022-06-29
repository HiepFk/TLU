#include<iostream>
using namespace std;
int check(int year, int month, int day) {
        if (month < 3) {
            year--;
            month += 12;
        }
        return 365*year + year/4 - year/100 + year/400 + (153*month - 457)/5 + day - 306;
    }


int main()
{
    int a,b,c,m,n,p;
    /* cin>>a>>b>>c>>m>>n>>p;
    int C= check(c,b,a) - check(p,n,m);
    if(C<0){cout<<0-C;}
    if(C>=0){cout<<C;} */
    cin>>a>>b>>c;
    cout<<check(c,b,a);

}