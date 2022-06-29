#ifndef list_h
#define list_h
template <class T>
class List 
{
private:
  T a[100];
  int N;
public:
  List()
  {
    N = 0;
  };
  void Add(T v)
  {
    a[N] = v;
    N++;
  };
  friend ostream& operator<<(ostream &o, List<T> l)
  {
    for(int i = 0; i<l.N; i++)
      o<<l.a[i]<<" ";
    return o;
  };
  T GetItem(int pos) const
  {
    return a[pos-1];
  };
  int Count() const
  {
    return N;
  };
  void Delete(int pos)
  {
    for(int i = pos; i<= N-1; i++)
      a[i-1] = a[i];
    N--;
  };
};
#endif