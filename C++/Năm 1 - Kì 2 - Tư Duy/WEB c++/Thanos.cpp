#include <iostream>
#include <string>
using namespace std;
string names[] = {"Power", "Time", "Space", "Soul", "Reality", "Mind"};
string colors[] = {"purple", "green", "blue", "orange", "red", "yellow"};
bool checkGem(string color, string x[], int n) {
    for (int i=0; i <n; i++) {
        if (x[i].compare(color) == 0) {
            return true;
        }
    }
    return false;
}
int main()
{
    int n;
    cin >> n; 
    cin.ignore();
    string x[6]; 
    for ( int i = 0; i < n; i++)
    {
        getline(cin, x[i]);
    };
    int count = 0;
    string s = "";
    for (int i = 0; i < 6; i++) { 
        bool check = checkGem(colors[i], x, n);
        if (check == false) { 
            s = s + names[i] + "\n";
            count ++;
        }
    }
    cout << count << endl;
    cout << s;
	return 0;
}