#include<iostream>
using namespace std;
#include<math.h>
#define MAX 100
void Nhap_Mang(int a[], int n)
{
	for (int i = 0; i < n; i++)
	{cin >> a[i];}
}
int UCLN(int a, int b) {
    if (b == 0) return a;
    return UCLN(b, a % b);
}
int Tim_UCLN_Mang(int a[], int n)
{
	int x = a[0]; 
	for (int i = 1; i < n; i++)
	{
		x = UCLN(x, a[i]); 
	}
	return x;
}
int main()
{
	int a[MAX];
	int n;
	cin >> n;
    Nhap_Mang(a, n);
    cout <<Tim_UCLN_Mang(a, n);
	return 0;
}