#include<string.h>
#include <fstream>
using namespace std;
void Menu();
class Tho
{
    private : 
        string name;
        string NoiDung;
    public : 
        friend ostream &operator<<(ostream &os, const Tho &t)
        {
            os<<t.name<<"\n"<<t.NoiDung<<endl;
            return os;
        }
        friend istream &operator>>(istream  &is, Tho &t)
        {   cout<<"Tac Gia: ";
            getline(is,t.name);
            cout<<"Noi dung: ";
            getline(is,t.NoiDung);
            return is;
        }
        void hienThiTen()
        {
            cout<<name<<endl;
        }
        void hienThiND()
        {
            cout<<NoiDung<<endl;
        }
        void nhap()
        {   
            cout<<"Name : "; getline(cin,name);
            cout<<"Noidung : ";getline(cin,NoiDung,'/');
        }
            friend void DocFile(Tho a[], int &n)
            {
                ifstream fin("Tho.txt");
                fin>>n;
                fin.ignore();
                for(int i=0;i<n;i++)
                {    
                    getline(fin, a[i].name);
                    getline(fin, a[i].NoiDung,'.');
                    fin.ignore();
                }
                fin.close();
                Menu();
            }
            friend void LuuFile(Tho a[], int n)
            {
                ofstream fout("Tho.txt");
                fout<<n<<endl;
                for(int i=0;i<n;i++)
                {   
                    fout<<a[i].name<<endl;
                    fout<<a[i].NoiDung<<"."<<endl;
                    
                }
                fout.close();
                Menu();
            }
       
};      
        void Menu();
        void rturn()
        {
            int x ; 
            cout<<endl;
            cout<<"Chose 0 to back menu : ";
            cin>>x;
            Menu();
        }
        void nhapDS(Tho a[],int &n)
        {
            cin.ignore();
            {a[n].nhap();}
            n++;
            rturn();
        };
        void hienthiDS(Tho a[], int n)
        {
            cout<<"     Danh sách thơ : "<<endl;
            for(int i=0;i<n;i++){
                cout<<i+1<<":";
                a[i].hienThiTen();
            }
            cout<<endl;
            cout<<"Bài thơ bạn muốn xem : ";
            int k ; 
            cin>>k;
            a[k-1].hienThiND();
            rturn();
            
        };
        
        Tho h[100];
        int n=0;
        void Menu()
        {   
            system("CLS");
            cout<<"      MENU  "<<endl;
            cout<<" 1.Thêm Thơ "<<endl;
            cout<<" 2.DS Thơ"<<endl;
            cout<<" 3.Đọc File"<<endl;
            cout<<" 4.Lưu File"<<endl;
            cout<<" 5.Exit"<<endl;
            cout<<" Choose the option : ";
            int chon;
            cin>>chon;
             switch (chon)
            {
            case 1 : 
                nhapDS(h,n);
                break;
            case 2 :
                hienthiDS(h,n); 
                break;
            case 3 : 
                DocFile(h,n);
                break;
            case 4 : 
                LuuFile(h,n);
                break;
            default :
                exit(1);
            }
        }
        