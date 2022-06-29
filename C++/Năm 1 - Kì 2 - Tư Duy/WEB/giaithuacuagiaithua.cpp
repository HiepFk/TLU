#include<iostream>
using namespace std;
int main()
{
	int n;
	cin>>n;
	int s=1;
	for (int i=1; i<n+1; i++){
	s=s*i;}
	//cout<<s<<endl;
	int d=s;

	int S=1;
	for (int y=1;y<d+1;y++){
	S=S*y;}
	cout<<S;
}
