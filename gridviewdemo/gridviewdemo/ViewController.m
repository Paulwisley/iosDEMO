//
//  ViewController.m
//  gridviewdemo
//
//  Created by Paul on 2018/12/29.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//
//学习用代码直接编写控件

#import "ViewController.h"
#import "subApp.h"
#import "CZView.h"
@interface ViewController ()

@property(nonatomic,  strong) NSArray *appInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //测试数据有没有正确加载
    NSLog(@"%@",self.appInfo);
    
    //计算frame
    CGFloat subviewW = 100;
    CGFloat subviewH = 100;
    //子view的横向间距 = （父view的宽度 - 3 * 子view的宽度 ）/ 4
    CGFloat marginX = (self.view.frame.size.width - 3 * subviewW) / 4;
    CGFloat marginY = 20;
    
    for(int i = 0; i < self.appInfo.count; i++){
        //手动动态创建子view
        //UIView *subview = [[UIView alloc] init];
        //NSBundle *bundle = [NSBundle mainBundle];
        //UIView *subview = [[bundle loadNibNamed:@"APPInfoView" owner:nil options:nil] lastObject];
        //bundle loadNibNamed 返回的是一个数组
        CZView *subview = [CZView AppInfoView];
        [self.view addSubview:subview];
        

        int  row = i / 3;
        int column = i % 3;
        //子view的横坐标 = 子view的横向间距 + 列号 * (子view的横向间距 + 子view的宽度)
        CGFloat subviewX = marginX + column * (marginX + subviewW);
        //子view的纵坐标 = 20 + 行号 * (子view的纵向间距 —— 子view的高度)‘
        CGFloat subviewY = 30 + row * (marginY + subviewH);
        subview.frame = CGRectMake(subviewX, subviewY, subviewW, subviewH);
        subApp *appInfo = [[subApp alloc] init];
        appInfo = _appInfo[i];
        //[self displayAppInf:appInfo subview:subview];
        
        //给subview的子控件赋值
        //subview.subviews 属性取出相应的控件
        //[subview viewWithTag:<#(NSInteger)#> 或者使用viewWithTag属性取控件，
        //但是取出来的控件类型 是UIView类型的，这时候需要强制类型转换 与我们想要取出的控件进行匹配
        //UIImageView *icon = subview.subviews[0];
        //icon.image= [UIImage imageNamed:appInfo.icon];
        //UILabel *label = (UILabel *)[subview viewWithTag:1];
        //label.text = appInfo.name;
        
        subview.appinfo = appInfo;
        
        UIButton *button = subview.subviews[2];
        [button setTitle:@"下载" forState:UIControlStateNormal];
        [button addTarget: self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    }
}

 //从plist中加载数据
-(NSArray *)appInfo{
    if(_appInfo == nil){
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"pics" ofType:@"plist"];
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
        //_appInfo = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tmp = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            subApp *appInfo = [[subApp alloc] init];
            appInfo.name = dic[@"name"];
            appInfo.icon = dic[@"icon"];
            [tmp addObject:appInfo];
        }
        _appInfo = tmp;
    }
    return _appInfo;
}

//展示子控件
-(void)displayAppInf:(subApp *)appinfo subview:(UIView *)subview{
    CGFloat subviewW = subview.frame.size.width;
    
    //iconview
    UIImageView *iconimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:appinfo.icon]];
    [subview addSubview:iconimage];
    //计算框架的位置
    CGFloat iconW = 60;
    CGFloat iconH = 60;
    CGFloat iconX = (subviewW - iconW) / 2;
    CGFloat iconY = 0;
    iconimage.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    //nameview
    UILabel *nameview = [[UILabel alloc] init];
    [subview addSubview:nameview];
    //计算name框架位置
    CGFloat nameW = subviewW;
    CGFloat nameH = 20;
    CGFloat nameX = 0;
    CGFloat nameY = iconH;
    nameview.frame = CGRectMake(nameX, nameY, nameW, nameH);
    nameview.text = appinfo.name;
    //文字大小
    nameview.font = [UIFont systemFontOfSize:15];
    //文字居中
    nameview.textAlignment = NSTextAlignmentCenter;
    
    //downloadbutton
    UIButton *downloadBtn = [[UIButton alloc] init];
    [subview addSubview:downloadBtn];
    //计算按钮位置
    CGFloat btnW = iconW;
    CGFloat btnH = 20;
    CGFloat btnX = iconX;
    CGFloat btnY = CGRectGetMaxY(nameview.frame);
    downloadBtn.frame = CGRectMake(btnX, btnY,btnW, btnH);
    [downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
    [downloadBtn setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
    downloadBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [downloadBtn addTarget: self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnclick{
    NSLog(@"= =");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) makeframe:(UIView *) view{
     
}

@end
