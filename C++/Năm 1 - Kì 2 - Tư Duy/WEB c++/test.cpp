#include<iostream>
using namespace std;
void phanTichSoNguyen(int n) {
    int d;
    cin>>d;
    int i = 2;
    int dem = 0;
    int a[100];
    while (n > 1) {
        if (n % i == 0) {
            n = n / i;
            a[dem++] = i;
        } else {
            i++;
        }
    }
    if (dem == 0) {
        a[dem++] = n;
    }
    cout<< a[d-1];
}

int main() {
    int n;
    cin >> n;
    phanTichSoNguyen(n);
}