//
//  Listener.m
//  broadcastDemo
//
//  Created by Paul on 2018/12/4.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import "Listener.h"

@implementation Listener

-(void)wantToListen{
    // 1. register
    [[NSNotificationCenter defaultCenter] addObserver:self
                                        selector:@selector(recvBcast:)
                                        name:@"Broadcast"
                                        object:nil];
}
    // 2. receive info
- (void) recvBcast:(NSNotification *)notify{
    NSString *name = notify.name;
    NSLog(@"notify is %@", notify);
}
@end
