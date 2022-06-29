#include <string>
#include <string.h>
#include <iostream>
using namespace std;
string check(string n)
{
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
        "see you",
        "I_am_happy",
        "I_am_unhappy",
        "wink",
        "stick_out_my_tongue",
        "sleepy",
        "totally_awesome",
        "Canadian_Computing_Competition",
        "because",
        "thank_you",
        "you_are_welcome",
        "talk_to_you_later",
    };
    for(int i = 0; i< 12; i++) {
        if(shortKey[i].find(n) != string ::npos) {
            return translate[i];
        }
    }
    return n;
}
int main() {
    
    string key;
    getline(cin, key);
    cout<<check(key);
    return 0;
}