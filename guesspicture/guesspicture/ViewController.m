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
@property(nonatomic, weak) IBOutlet UIButton *btnlast;
@property(nonatomic, weak) IBOutlet UIButton *btnnext;
@property(nonatomic, weak) IBOutlet UIButton *coin;

@property(nonatomic, assign) int index; //控制图片索引
@property(nonatomic, weak) UIButton *coverview; //遮盖按钮
@property(nonatomic, assign) CGRect oldframe; //保存原有的图片frame

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
    self.btnlast.enabled = NO;//暂时不让点
    self.coin.userInteractionEnabled = NO;
    self.image.image = [UIImage imageNamed:info.icon];
    [self initAnswerSubview:info WithSubview:self.answerview];
    [self initOptionSubview:info WithSubiew:self.panelView];
    UITapGestureRecognizer *uitapgest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictClick)];
    [self.image addGestureRecognizer:uitapgest];
    self.image.userInteractionEnabled = YES;
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
        [option addTarget:self action:@selector(matchAnswer:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(IBAction)btnHelp{
    
}

//获取下一组图
-(IBAction)btnNextQ{
    self.index++;
    if(self.index == _pictureInfo.count - 1){
        self.btnnext.enabled = NO;
        self.btnlast.enabled = YES;
        //undo add alert
    }else{
        self.btnnext.enabled = YES;
        self.btnlast.enabled = YES;
    }
    PictureInfo *picinfo = [[PictureInfo alloc] init];
    picinfo = self.pictureInfo[self.index];
    self.image.image = [UIImage imageNamed:picinfo.icon];
    NSString *labeltext = [NSString stringWithFormat:@"%d/%lu",self.index+1,_pictureInfo.count];
    self.labelIndex.text = labeltext;
    [self initAnswerSubview: picinfo WithSubview:self.answerview];
    [self initOptionSubview: picinfo WithSubiew:self.panelView];
    //undo not set constraint
}

//获取上一组图
-(IBAction)btnLastQ{
    self.index--;
    if(self.index == 0){
        self.btnlast.enabled = NO;
        self.btnnext.enabled = YES;
        //undo add alert
    }else{
        self.btnlast.enabled = YES;
        self.btnnext.enabled = YES;
    }
    PictureInfo *picinfo = [[PictureInfo alloc] init];
    picinfo = self.pictureInfo[self.index];
    NSString *labeltext = [NSString stringWithFormat:@"%d/%lu",self.index+1,_pictureInfo.count];
    self.labelIndex.text = labeltext;
    self.image.image = [UIImage imageNamed: picinfo.icon];
    [self initAnswerSubview:picinfo WithSubview:self.answerview];
    [self initOptionSubview:picinfo WithSubiew:self.panelView];
    //uudo not set constraint
}

//点开大图
-(IBAction)btnEnlarge{
//改变现有图片的frame
//返回原来图片的控制区域设定
    self.oldframe = self.image.frame;
    CGFloat picW = self.view.frame.size.width;
    CGFloat picH = picW;
    CGFloat picX = 0;
    CGFloat picY = (self.view.frame.size.height - picH) / 2;
    //self.image.frame = CGRectMake(picX, picY, picW, picH);
    
    //新生成一个覆盖按钮 覆盖剩余部分
    UIButton *cover = [[UIButton alloc] init];
    [self.view addSubview:cover];
    self.coverview = cover;
    cover.frame = self.view.bounds;
    [cover setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cover.alpha = 0;
    
    //将当前view的一个子view置于顶层
    [self.view bringSubviewToFront:self.image];
    //动画
    [UIView animateWithDuration:1.0 animations:^{
        self.image.frame = CGRectMake(picX, picY, picW, picH);
        cover.alpha = 0.5;
    }];
    
    [cover addTarget:self action:@selector(smallPic) forControlEvents:UIControlEventTouchUpInside];
}

-(void)smallPic{
    [UIView animateWithDuration:1.0 animations:^{
        self.image.frame = self.oldframe;
        self.coverview.alpha = 0;
    }
   completion:^(BOOL finished) {
         [self.coverview removeFromSuperview];
    }];
}

-(void)pictClick{
    if(self.coverview == nil){
        [self btnEnlarge];
    }else{
        [self smallPic];
    }
}

-(IBAction)btnShare{
    
}

-(void)matchAnswer:(UIButton *)option{
    //找到答案区域还未初始化的view， 用当下btn的值赋给答案区域
    for (UIButton *btn in self.answerview.subviews) {
        if(btn.titleLabel == nil){
            [btn setTitle:option.titleLabel.text forState:UIControlStateNormal];
            btn.tag = option.tag; //传入指定tag 以便之后发生错误进行回退
        }
    }
    [UIView animateWithDuration:1.0 animations:^{
        [option removeFromSuperview];
    }];
}
@end
