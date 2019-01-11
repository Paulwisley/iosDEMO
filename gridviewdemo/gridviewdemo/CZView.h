//
//  CZView.h
//  gridviewdemo
//
//  Created by Paul on 2019/1/11.
//  Copyright © 2019 Dingzhijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class subApp;
@interface CZView : UIView

@property(nonatomic, strong) subApp *appinfo;
+(instancetype)AppInfoView;

@end
