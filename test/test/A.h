#include <iostream>
#include <fstream>
#include <string>

using  namespace std ;
class A{
    
public:

     A(){
         i = "";
     }
    
    A(string j){
        i = j;
    }
    
    int Serialize(char* pBuffer){
        long length = sizeof(*this);
        //cout<<"this length = "<<length<<endl;
        ofstream *o = new ofstream(pBuffer);
        o->write((char *)this, length);
        o->close();
        delete o;
        return 1;
    }
    
    static A Deserialize(const char* pBuffer){
        char buf[1000];
        ifstream is(pBuffer);
        //初始化ifstream对象
        is >> buf;
        //cout<<"反序列化输出buf = "<<buf<<endl;
        A *a = new A(buf);
        is.close();
        //a->i.append(buf);
        //cout<< a->i <<endl;
        return (*a);
    }
    
    void f(){
        cout << "反序列化输出 str = " << this->i << endl;
    }
    
private:
    string i;
    
};
