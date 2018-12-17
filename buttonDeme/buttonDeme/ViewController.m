//
//  ViewController.m
//  buttonDeme
//
//  Created by Paul on 2018/12/14.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


//添加控件
//1. 向上箭头

@property(nonatomic,weak) IBOutlet UIButton *btnUp;
@property(nonatomic,weak) IBOutlet UIButton *btnDown;
@property(nonatomic,weak) IBOutlet UIButton *btnRight;
@property(nonatomic,weak) IBOutlet UIButton *btnLeft;

@property(nonatomic,weak) IBOutlet UIButton *changePic;

/**向上移动*/
-(IBAction)moveUp;

/**向下移动*/
-(IBAction)moveDown;

/**向左移动*/
-(IBAction)moveLeft;

/**向右移动*/
-(IBAction)moveRight;

/**旋转图片*/
-(IBAction)rotate;

/**放大图片*/
-(IBAction)zoomBig;

/**缩小图片*/
-(IBAction)zoomSmall;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)moveUp{
    //图片位置 存储在CGRect 结构体当中 使用临时frame变量 改变 相应的值 然后再赋值回去
    //transform 矩阵变换 和 frame中x y 坐标不同
    //transformmake 是在原始位置平移
    //将图片的transform 座位参数传入 这样可以在新改变的位置山进行平移
    
    /*
    CGRect frame = self.changePic.frame;
    frame.origin.y -= 10;
    self.changePic.frame = frame;
     */
    self.changePic.transform = CGAffineTransformTranslate(self.changePic.transform,0,-10);
}

-(IBAction)moveDown{
    /*
    CGRect frame = self.changePic.frame;
    frame.origin.y += 10;
    self.changePic.frame = frame;
    */
    
    //或者使用CGAffineTransformMake or CGAffineTransformTranslate
    // make 是相当于控件的原始位置做的变换 而 translate是根据上一次的变换做的变化
    self.changePic.transform = CGAffineTransformTranslate(self.changePic.transform,0,10);
}

-(IBAction)moveLeft{
    /*
    CGRect frame = self.changePic.frame;
    frame.origin.y -= 10;
    self.changePic.frame = frame;
     */
    self.changePic.transform = CGAffineTransformTranslate(self.changePic.transform,-5,0);
}

-(IBAction)moveRight{
    /*
    CGRect frame = self.changePic.frame;
    frame.origin.y += 10;
    self.changePic.frame = frame;
     */
    self.changePic.transform = CGAffineTransformTranslate(self.changePic.transform,5,0);
}

-(IBAction)rotate{
    self.changePic.transform = CGAffineTransformRotate(self.changePic.transform, M_PI_4/3);
}

-(IBAction)zoomBig{
    self.changePic.transform = CGAffineTransformScale(self.changePic.transform, 1.1, 1.1);
}

-(IBAction)zoomSmall{
    self.changePic.transform = CGAffineTransformScale(self.changePic.transform, .8, .8);
}



@end
