//
//  ThemeManager.h
//  singleTonDemo
//
//  Created by Paul on 2018/12/4.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject
{
    NSString* _name;
}
@property(nonatomic,retain)NSString* name;
+(id)sharedMyManager;
@end
