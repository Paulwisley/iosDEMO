//
//  ViewController.m
//  ImageViewDemo
//
//  Created by Paul on 2018/12/17.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/** head label */
@property(nonatomic,weak) IBOutlet UILabel *labelTitle;
/** footer label */
@property(nonatomic,weak) IBOutlet UILabel *labelFoot;
/** image view */
@property(nonatomic,weak) IBOutlet UIImageView *imageView;

@property(nonatomic,weak) IBOutlet UIButton *leftBtn;
@property(nonatomic,weak)IBOutlet UIButton *rightBtn;
@property(nonatomic,assign) int index;
@property(nonatomic,assign) NSArray *arr;
-(IBAction) btnLeft;
-(IBAction) btnRight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeIndex];
    //NSString *path = [[NSBundle mainBundle] bundlePath]; Bundle 路径
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSArray *)Array
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Imagetext" ofType:@"plist"];
    if(_arr == nil)
    {
        _arr = [NSArray arrayWithContentsOfFile:path];
        NSLog(@"%@",_arr);
    }
    return _arr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnLeft
{
    self.index--;
    [self changeIndex];
    self.leftBtn.enabled = self.index != 0;
}

-(IBAction)btnRight
{
    self.index++;
    [self changeIndex];
    self.rightBtn.enabled = self.index != 5;
}

-(void)changeIndex
{
    NSArray *imageArr = [self Array];
    //NSLog(@"%@",[imageArr objectAtIndex:self.index]);
    switch (self.index) {
        case 0:
            [self setImage:[imageArr objectAtIndex:self.index][@"icon"] setIndex:self.index setText:[imageArr objectAtIndex:self.index][@"text"]];
            break;
        case 1:
         [self setImage:[imageArr objectAtIndex:self.index][@"icon"] setIndex:self.index setText:[imageArr objectAtIndex:self.index][@"text"]];
            break;
        case 2:
        [self setImage:[imageArr objectAtIndex:self.index][@"icon"] setIndex:self.index setText:[imageArr objectAtIndex:self.index][@"text"]];
            break;
        case 3:
        [self setImage:[imageArr objectAtIndex:self.index][@"icon"] setIndex:self.index setText:[imageArr objectAtIndex:self.index][@"text"]];
            break;
        default:
            break;
    }
}

-(void) setImage:(NSString *)imagename setIndex:(int) index setText:(NSString *) text
{
    self.imageView.image = [UIImage imageNamed:imagename];
    self.labelTitle.text = [NSString stringWithFormat:@"%d/%lu",index,[self Array].count-0];
    self.labelFoot.text = text;
}

@end
