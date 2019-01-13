//
//  PictureInfo.h
//  guesspicture
//
//  Created by DINGZHIJIAN on 2019/1/13.
//  Copyright © 2019 DINGZHIJIAN. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PictureInfo : NSObject

@property(nonatomic, strong) NSString* answer;
@property(nonatomic, strong) NSString* icon;
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSArray* options;

@end
