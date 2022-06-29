#include <iostream>
using namespace std;
void Thap(int n,char a,char b,char c){
    if(n==1){
        cout<<a<<" --> "<<c<<endl;
        cout<<endl;
    }
    else{
        Thap(n-1,a,c,b);
        Thap(1,a,b,c);
        Thap(n-1,b,a,c);
    }
}
int main(){
    Thap(6,'A','B','C');
    return 0;
}