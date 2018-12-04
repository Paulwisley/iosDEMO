//
//  Broadcast.m
//  broadcastDemo
//
//  Created by Paul on 2018/12/4.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import "Broadcast.h"

@implementation Broadcast
-(void)broadcastLooper{
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(broadcast) userInfo:(nil) repeats:YES];
    //启动一个定时器， 循环的发送广播
}

-(void)broadcast{
    // 1. 取得通知中心
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    static int i;
    NSString *count = [NSString stringWithFormat:@"bcast %d", ++i];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"broadcast", @"name",
                          count, @"Value",
                          nil];
    //消息内容
    // 2. 发送广播
    [nc postNotificationName:@"Broadcast" object:self userInfo:dict];
    //param1 广播频段 广播的类名
}


@end
