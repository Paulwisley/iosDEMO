//
//  ThemeManager.m
//  singleTonDemo
//
//  Created by Paul on 2018/12/4.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager
@synthesize name = _name;
static id sharedMyManger;
+(id)sharedMyManager{
    if(sharedMyManger == nil){
        sharedMyManger = [[self alloc] init];
    }
    return sharedMyManger;
}

//配合多线程带加锁的写法
/*
 +(id)sharedManager{
 //只能一个线程调用
    @synchronized(self){
        if(sharedMyManager == nil){
            sharedMyManager = [[self alloc] init];
        }
    }
    return sharedMyManager;
 }
 
 */

//第一次实例化创建lock free
+(void)initialize{
    static BOOL initialized = NO;
    if(initialized == NO){
        initialized = YES;
        sharedMyManger = [[self alloc] init];
    }
}

//GCD写法
+(id)sharedMyManager1{
    static dispatch_once_t once;
    //dispatch_once 保证了该block只能被执行一次
    dispatch_once(&once,^{
        sharedMyManger = [[self alloc] init];
    });
    return sharedMyManger;
}


//重载一些方法

/*
+(id)allocWithZone:(struct _NSZone *)zone{
    return [[self sharedMyManager] retain];
}
 */

+(id)copyWithZone:(NSZone*) zone{
    return self;
}

+(id)retain{
    return self;
}

//在单例中  不能release
+(oneway void)release{
    
}
//在单例中 也不能autorelease
+(id)autorelease{
    return self;
}











@end
