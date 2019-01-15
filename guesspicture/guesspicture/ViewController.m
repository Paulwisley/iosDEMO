//
//  ViewController.m
//  guesspicture
//
//  Created by DINGZHIJIAN on 2019/1/13.
//  Copyright © 2019 DINGZHIJIAN. All rights reserved.
//

#import "ViewController.h"
#import "PictureInfo.h"

@interface ViewController ()

@property(nonatomic, strong) NSArray *pictureInfo;
@property(nonatomic, weak) IBOutlet UILabel *labelIndex;
@property(nonatomic, weak) IBOutlet UILabel *labelTitle;
@property(nonatomic, weak) IBOutlet UIImageView *image;
@property(nonatomic, weak) IBOutlet UIView *answerview;
@property(nonatomic, weak) IBOutlet UIView *panelView;

@property(nonatomic, weak)IBOutlet UIButton *coin;
-(IBAction)btnHelp;
-(IBAction)btnNextQ;
-(IBAction)btnLastQ;
-(IBAction)btnEnlarge;
-(IBAction)btnShare;
-(void)initAll;
-(void)initSubview:(PictureInfo *) picinfo WithSubview:(UIView *)subview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self pictureInfo];
    [self initAll];
}

//懒加载plist数据
-(NSArray *)pictureInfo{
    if(_pictureInfo == nil){
        NSBundle *bundle = [NSBundle mainBundle];
        NSString *path = [bundle pathForResource:@"pictureInfo" ofType:@"plist"];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tmp = [NSMutableArray array];
        for (NSDictionary *dic in dictArray) {
            PictureInfo *picinfo = [[PictureInfo alloc] init];
            picinfo.icon = dic[@"icon"];
            picinfo.answer = dic[@"answer"];
            picinfo.title = dic[@"title"];
            picinfo.options = dic[@"options"];
            [tmp addObject:picinfo];
        }
        _pictureInfo = tmp;
    }
    //NSLog(@"%@",_pictureInfo);
    return _pictureInfo;
}

//初始化界面控件内容
-(void)initAll{
    PictureInfo *info = [[PictureInfo alloc] init];
    info = self.pictureInfo[0];
    NSString *indexText = [NSString stringWithFormat:@"1/%lu",self.pictureInfo.count];
    self.labelIndex.text = indexText;
    self.labelTitle.text = info.title;
    self.image.image = [UIImage imageNamed:info.icon];
    [self initSubview:info WithSubview:self.answerview];
}

//初始化备选框和答案区域内容
-(void)initSubview:(PictureInfo *)picinfo WithSubview:(UIView *)subview{
    [subview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int count = (int)[picinfo.answer length];
    NSLog(@"%d",count);
    for(int i = 0; i < count; i++){
        UIButton *ans = [[UIButton alloc] init];
        [subview addSubview: ans];
        [ans setTitle: @"d" forState:UIControlStateNormal];
        [ans setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [ans setBackgroundImage:[UIImage imageNamed:@"btn_answer"]forState:UIControlStateNormal];
        CGFloat btnW = 40;
        CGFloat btnH = 43;
        CGFloat btnX = (subview.frame.size.width - count * btnW - (count - 1) * 10) / 2 + (10 + btnW) * i;
        CGFloat btnY = [subview viewWithTag:23].frame.origin.y;
        ans.frame = CGRectMake(btnX, btnY, btnW, btnH);
        ans.enabled = YES;
        //[self.view.subview[]
    }
}

-(IBAction)btnHelp{
    
}

-(IBAction)btnNextQ{
    
}

-(IBAction)btnLastQ{
    
}

-(IBAction)btnEnlarge{
    
}

-(IBAction)btnShare{
    
}

@end
