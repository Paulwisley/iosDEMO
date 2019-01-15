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
    [self initAnswerSubview:info WithSubview:self.answerview];
    [self initOptionSubview:info WithSubiew:self.panelView];
}

//初始化备选框和答案区域内容
//初始化答案区域
-(void)initAnswerSubview:(PictureInfo *)picinfo WithSubview:(UIView *)subview{
    [subview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int anscount = (int)[picinfo.answer length];
//    NSLog(@"%d",count);
    for(int i = 0; i < anscount; i++){
        UIButton *ans = [[UIButton alloc] init];
        [subview addSubview: ans];
        [ans setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [ans setBackgroundImage:[UIImage imageNamed:@"btn_answer"]forState:UIControlStateNormal];
        [ans setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        CGFloat btnW = 40;
        CGFloat btnH = 43;
        CGFloat btnX = (subview.frame.size.width - anscount * btnW - (anscount - 1) * 10) / 2 + (10 + btnW) * i;
        CGFloat btnY = 0;
        ans.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [ans setTitle: @"" forState:UIControlStateNormal];
        //ans.enabled = YES;
        //[self.view.subview[]
    }
}

//初始化备选框
-(void)initOptionSubview:(PictureInfo *)picinfo WithSubiew:(UIView *)subview{
    [subview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];//所有的控件都执行remove方法
    //init option view
    NSInteger optioncount = picinfo.options.count;
    for(int i = 0; i < optioncount; i++){
        UIButton *option = [[UIButton alloc] init];
        [subview addSubview:option];
        [option setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [option setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [option setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        //计算各个小btn的位置
        int col = i % 7;
        int row = i / 7;
        int margin = 10;
        CGFloat btnW = (subview.frame.size.width - 8 * margin) / 7;
        CGFloat btnH = (subview.frame.size.height  - 4 * margin) / 3;
        CGFloat btnX = margin * (1 + col) + col * btnW ;
        CGFloat btnY = margin * (1 + row) + row * btnH;
        option.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [option setTitle:picinfo.options[i] forState:UIControlStateNormal];
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
