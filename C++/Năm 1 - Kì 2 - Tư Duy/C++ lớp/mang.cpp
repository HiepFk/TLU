#include <iostream>
#include <fstream>
#include <string.h>
#include <stdlib.h>

using namespace std;
int board[3][3];

void printBoard(int a[][3]) {
	for(int i =0; i<3; i++)
	{
	 cout << endl;
	 for(int j=0; j<3; j++)
	   cout<<a[i][j];
	}
	   cout << endl;
	
}

void selectCell(int type, int x, int y){
	board[x][y] = type;
	}

int main(){
	
	for(int i =0; i<3; i++)
	 for(int j=0; j<3; j++)
	   board[i][j] =0; 
	
	const int X=1;
	const int O=2; 
	
	selectCell(X,0,0);
	selectCell(O,1,1);
	printBoard(board); 
return 1;
}
