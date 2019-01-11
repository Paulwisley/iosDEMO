//
//  main.cpp
//  test
//
//  Created by Paul on 2018/12/22.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#include "A.h"
int main(int argc, const char * argv[]) {
    A u;
    //cout<<"length u(未初始化对象) = " <<sizeof(u)<<endl;
    A a = A("uestc");
    //cout<<"length a = " <<sizeof(a)<<endl;
    a.Serialize("data");
    
    A b = A::Deserialize("data");
    b.f();
    return 0;
}


