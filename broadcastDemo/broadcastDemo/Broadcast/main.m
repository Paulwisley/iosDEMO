//
//  main.m
//  broadcastDemo
//
//  Created by Paul on 2018/12/4.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Listener.h"
#import "Broadcast.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        Broadcast *bcast = [[Broadcast alloc] init];
        [bcast broadcast];
        /*
         *如果 只调用一个broadcast，即广播若只发送一次的话，先发广播再接收 则无法接收到，，必须改为先接收再广播
         *若要保持先广播再接收 必须得循环广播 调用下面looper函数
         */
        
        [bcast broadcastLooper];
        Listener *l1 = [[Listener alloc] init];
        [l1 wantToListen];
        [[NSRunLoop currentRunLoop] run];
        return 0;
    }
}
