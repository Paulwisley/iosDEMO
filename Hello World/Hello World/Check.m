//
//  Check.m
//  Hello World
//
//  Created by Paul on 2018/12/14.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import "Check.h"

@implementation Check


-(BOOL)checkNum:(NSString *)num{
    //check the length of the num
    NSInteger numLength = [num length];
    if(numLength > 11 || numLength < 4)
    {
        NSLog(@"QQ账号格式错误 请重新输入");
        return NO;
    }
    return YES;
}

-(BOOL)checkPsw:(NSString *)passwd{
    if(passwd.length == 0){
        NSLog(@"密码不能为空");
        return NO;
    }else{
        return YES;
    }
}

@end
