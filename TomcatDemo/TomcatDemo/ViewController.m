//
//  ViewController.m
//  TomcatDemo
//
//  Created by Paul on 2018/12/19.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,weak) IBOutlet UIImageView *imag;
@property(nonatomic,weak) IBOutlet UIButton *btnDrink;

-(IBAction)drinkMilk;
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

-(IBAction)drinkMilk
{
    NSString *imagename =  @"drink";
    [self changeImage:imagename inCount:81];

}

-(IBAction)eatFood
{
    NSString *imagename = @"eat";
    [self changeImage:imagename inCount:40];
}

-(IBAction)knockHead
{
    NSString *imagename = @"knockout";
    [self changeImage:imagename inCount:81];
}


-(IBAction)rightFoot
{
    NSString *imagename = @"foot_right";
    [self changeImage:imagename inCount:30];
}

-(IBAction)leftFoot
{
    NSString *imagename = @"foot_left";
    [self changeImage:imagename inCount:30];
}

-(void)changeImage:(NSString *)imgname inCount:(int)count
{
    if(self.imag.animating)
        return;
    NSMutableArray *images = [NSMutableArray array];
    for(int i = 0 ; i < count; i++)
    {
        NSString *imagename = [NSString stringWithFormat:@"%@_%02d",imgname,i];
        UIImage *img = [UIImage imageNamed:imagename];
        [images addObject:img];
    }
    //NSLog(@"1");
    // [UIImage animatedImageNamed:<#(nonnull NSString *)#> duration:<#(NSTimeInterval)#>]
    //[UIView beginAnimations: context:]
    self.imag.animationImages = images;
    self.imag.animationDuration = count * .08;
    self.imag.animationRepeatCount = 1;
    [self.imag startAnimating];
}

@end
