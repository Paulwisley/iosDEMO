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
    NSMutableArray *images = [NSMutableArray array];
    for(int i = 0 ; i < 81; i++)
    {
        NSString *imagename = [NSString stringWithFormat:@"drink_%02d",i];
        UIImage *img = [UIImage imageNamed:imagename];
        [images addObject:img];
    }
    // [UIImage animatedImageNamed:<#(nonnull NSString *)#> duration:<#(NSTimeInterval)#>]
    //[UIView beginAnimations: context:]
    self.imag.animationImages = images;
    self.imag.animationDuration = 81 * .08;
    self.imag.animationRepeatCount = 1;
    [self.imag startAnimating];
}

-(void)changeImage
{
    
}

@end
