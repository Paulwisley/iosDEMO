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
@property(nonatomic,strong) NSArray *arr;
//@property(nonatomic,assign) NSDictionary *dict;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnLeft
{
    self.index--;
    [self changeIndex];
}

-(IBAction)btnRight
{
    self.index++;
//    NSLog(@"%d",self.index);
    [self changeIndex];
}

-(NSArray *)arr
{
    if(_arr == nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Imagetext" ofType:@"plist"];
        _arr = [NSArray arrayWithContentsOfFile:path];
        //    NSLog(@"%@",_arr);
    }
    return _arr;
}

-(void)changeIndex
{
    NSDictionary *dict = self.arr[self.index];
    //NSLog(@"%@",[imageArr objectAtIndex:self.index]);
    switch (self.index) {
        case 0:
            [self setImage:dict[@"icon"] setIndex:self.index setText:dict[@"text"]];
            break;
        case 1:
            [self setImage:dict[@"icon"] setIndex:self.index setText:dict[@"text"]];
            break;
        case 2:
            [self setImage:dict[@"icon"] setIndex:self.index setText:dict[@"text"]];
            break;
        case 3:
            [self setImage:dict[@"icon"] setIndex:self.index setText:dict[@"text"]];
            break;
        default:
            break;
    }
    self.leftBtn.enabled = self.index != 0;
    self.rightBtn.enabled = self.index != self.arr.count - 1;
    
}

-(void) setImage:(NSString *)imagename setIndex:(int) index setText:(NSString *) text
{
    self.imageView.image = [UIImage imageNamed:imagename];
    self.labelTitle.text = [NSString stringWithFormat:@"%d/%lu",self.index + 1, self.arr.count];
    self.labelFoot.text = text;
}

@end
