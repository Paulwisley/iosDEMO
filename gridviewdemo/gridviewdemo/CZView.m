//
//  CZView.m
//  gridviewdemo
//
//  Created by Paul on 2019/1/11.
//  Copyright © 2019 Dingzhijian. All rights reserved.
//

#import "CZView.h"
#import "subApp.h"

@interface CZView()

@property(weak, nonatomic) IBOutlet UIImageView *iocn;
@property(weak, nonatomic) IBOutlet UILabel *descriLabel;

-(IBAction)download:(UIButton *)sender;
@end

@implementation CZView

+(instancetype)AppInfoView{
    //手动动态创建子view
    //UIView *subview = [[UIView alloc] init];
    NSBundle *bundle = [NSBundle mainBundle];
    UIView *subview = [[bundle loadNibNamed:@"APPInfoView" owner:nil options:nil] lastObject];
    //bundle loadNibNamed 返回的是一个数组
    return subview;
}


-(void)setAppinfo:(subApp *)appinfo{
    _appinfo = appinfo;//这句必须写
    self.iocn.image = [UIImage imageNamed:appinfo.icon];
    self.descriLabel.text = appinfo.name;
}

-(IBAction)download:(UIButton *)sender{
    self.superview.userInteractionEnabled = NO;
    sender.enabled = NO;
    UILabel *tipview = [[UILabel alloc] init];
    [self.superview addSubview:tipview];
    //初始化控件的位置以及其宽度，高度
    CGFloat tipW = 150;
    CGFloat tipH = 20;
    CGFloat tipX = (self.superview.frame.size.width - tipW) / 2;
    CGFloat tipY = (self.superview.frame.size.height - tipH) / 2;
    tipview.frame = CGRectMake(tipX, tipY, tipW, tipH);
    tipview.backgroundColor = [UIColor grayColor];
    tipview.alpha = 0.0;
    tipview.layer.cornerRadius = 10;
    tipview.layer.masksToBounds = YES;
    tipview.text = [NSString stringWithFormat:@"正在下载: %@",self.appinfo.name];
    
    [UIView animateWithDuration:1.0 animations:^{
        tipview.alpha = 0.9;
    }completion:^(BOOL finished){
    [UIView animateWithDuration:1.0 delay:3.0 options:UIViewAnimationOptionCurveLinear animations:^{
        tipview.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.superview.userInteractionEnabled = YES;
        [tipview removeFromSuperview];
    }];}
    ];
    //具体实现可以根据网络情况加上进度条
    
    
    
}
@end
