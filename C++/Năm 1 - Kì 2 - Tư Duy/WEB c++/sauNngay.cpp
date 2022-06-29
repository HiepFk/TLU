#include<iostream>
using namespace std;
int check(int year, int month, int day) {
        if (month < 3) {
            year--;
            month += 12;
        }
        return 365*year + year/4 - year/100 + year/400 + (153*month - 457)/5 + day - 306;
    }
int main(){
    int a,b,c,n;
    cin>>a>>b>>c>>n;
    float S;
    S= n+ check(c,b,a)+ 397.4;
    int x = S/365.2425;
    S= S- 365.2424*x;
    int y = S/30.6;
    S=S-30.6*y;
    int z = S+1;
    cout<<z<<" "<<y<<" "<<x;


}