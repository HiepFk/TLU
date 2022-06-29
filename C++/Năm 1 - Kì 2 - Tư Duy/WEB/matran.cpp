#include <iostream> 
#include <math.h> 
using namespace std;
int main()
{
	int x, y;
	cin>>x>>y;
	int a[x][y];
	for (int row=0;row<x;row++){
		for(int col=0;col<y;col++){
			cin>>a[row][col]; }}
	
	int S=0;
	for( int i=0;i<x;i++){
	for (int j=0;j<y;j++){
		
		if (i==j)
		S=S+a[i][j];}}
cout<<S;
	
}

