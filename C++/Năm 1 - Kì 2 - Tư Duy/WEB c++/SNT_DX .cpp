#include <iostream>
#include <math.h>
using namespace std;
int kiemtra(int i)
{
	int b=0, c, d;
	c=i;
	while (i>0){
		d=i%10;
		b=b*10+d;
		i=i/10;	
		}
	if (b==c){
		return true;}
	else{
		return false;}
}
int main()
{
    int n,j,i,dem;
    cin>>n;
    for (i=n;i>=2;i=i-1)
    {
        dem=0;
        for (j=2;j<=sqrt(i);j++)
        {
            if (i%j==0)
            {
            dem=dem+1;
            break;
            }
        }
    if (dem==0 && kiemtra(i)==true){cout<<i;break;}		
    }
return 0;
}