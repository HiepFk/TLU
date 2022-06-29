#include <string>
#include <string.h>
#include <iostream>
#include <fstream> // thao tac voi file

using namespace std;

int main() {
    string shortKey[] = {
        "CU",
        ":-)",
        ":-(",
        ";-)",
        ":-P",
        "(.)",
        "TA",
        "CCC",
        "CUZ",
        "TY",
        "YW",
        "TTYL",
    };

    string translate [] = {
        "CU	see you",
        ":-)	I_am_happy",
        ":-(	I_am_unhappy",
        ";-)	wink",
        ":-P	stick_out_my_tongue",
        "(.)	sleepy",
        "TA	totally_awesome",
        "CCC	Canadian_Computing_Competition",
        "CUZ	because",
        "TY	thank_you",
        "YW	you_are_welcome",
        "TTYL	talk_to_you_later",
    };


    cout <<" Nhap mot key bat ky: ";
    string key;
    getline(cin, key);
    cout << " key = " << key << endl;
    cout << " Nghia tuong ung: " ;
    for(int i = 0; i< 12; i++) {
        if (key.compare(shortKey[i]) == 0) {
            cout << i << "  " << translate[i];
            return 0;
        }
    }


    return 0;
}
