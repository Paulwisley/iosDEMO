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
@property(nonatomic, strong) NSMutableArray *correctcount; //正确的题目数

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
    //初始化NSMutableArray
    self.correctcount = [NSMutableArray array];
}

//初始化备选框和答案区域内容
//初始化答案区域
-(void)initAnswerSubview:(PictureInfo *)picinfo WithSubview:(UIView *)subview{
    [subview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int anscount = (int)[picinfo.answer length];
//    NSLog(@"%d",count);
    for(int i = 0; i < anscount; i++){
        UIButton *ans = [UIButton buttonWithType:UIButtonTypeCustom];
        [subview addSubview: ans];
        [ans setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [ans setBackgroundImage:[UIImage imageNamed:@"btn_answer"]forState:UIControlStateNormal];
        [ans setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        CGFloat btnW = 40;
        CGFloat btnH = 43;
        CGFloat btnX = (subview.frame.size.width - anscount * btnW - (anscount - 1) * 10) / 2 + (10 + btnW) * i;
        CGFloat btnY = 0;
        ans.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [ans addTarget:self action:@selector(resetAnswer:) forControlEvents:UIControlEventTouchUpInside];
        //NSLog(@"%d",ans.currentTitle == nil);
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
        option.tag = i+1;
        [option setTitle:picinfo.options[i] forState:UIControlStateNormal];
        [option addTarget:self action:@selector(matchAnswer:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(IBAction)btnHelp{
    
}

//获取下一组图
-(IBAction)btnNextQ{
    self.panelView.userInteractionEnabled = YES;
    //将答案框的字体颜色重置
    [self setAllBtnColor:[UIColor blackColor]];
    self.index++;
    if(self.index == _pictureInfo.count - 1){
        self.btnnext.enabled = NO;
        self.btnlast.enabled = YES;
    }else{
        self.btnnext.enabled = YES;
        self.btnlast.enabled = YES;
    }
    PictureInfo *picinfo = self.pictureInfo[self.index];
    self.image.image = [UIImage imageNamed:picinfo.icon];
    NSString *labeltext = [NSString stringWithFormat:@"%d/%lu",self.index+1,_pictureInfo.count];
    self.labelIndex.text = labeltext;
    [self initAnswerSubview: picinfo WithSubview:self.answerview];
    [self initOptionSubview: picinfo WithSubiew:self.panelView];
    
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

-(void)matchAnswer:(UIButton *)sender {
    //找到答案区域还未初始化的view， 用当下btn的值赋给答案区域
    sender.hidden = YES;
    for (UIButton *btn in self.answerview.subviews) {
        //NSLog(@"%@",btn.currentTitle);
        /**
         对于btn.currentTite 的理解
         首先， currentTitle是一个readonly变量
         未对title进行初始化时 currentTitle 其值为nil
         但归根结底 这是一个NSString类型变量
         */
        if(btn.currentTitle == nil){
            //NSLog(@"3");
            [btn setTitle:sender.currentTitle forState:UIControlStateNormal];
            btn.tag = sender.tag; //传入指定tag 以便之后发生错误进行回退
            break;
        }
    }
    BOOL isFull = YES;
    NSMutableString *strAns = [NSMutableString string];
    for (UIButton * btn in self.answerview.subviews) {
        if(btn.currentTitle == nil){
            isFull = NO;
            break;
        }
        [strAns appendString:btn.currentTitle];
    }
    if(isFull){
        //所有答案框都被填满 禁止输入
        self.panelView.userInteractionEnabled = NO;
        if([self isCheckAnswer:strAns]){
            [self.correctcount addObject:[NSNumber numberWithInt: self.index]];//加入正确题号
            //所有题答完通知正确
            if(self.correctcount.count == self.pictureInfo.count){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"恭喜你，过关啦!" preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:alert animated:YES completion:nil];
            }
            //更改ans字体
            [self setAllBtnColor:[UIColor blueColor]];
             /***加分
              1. 先将正确的题号加入正确题数的统计数组中
              2. 获取当前分数值
              3. 加分
              */
            int score = [self.coin.titleLabel.text intValue];//使用intValue 转成int
            score += 500;
            [self.coin setTitle:[NSString stringWithFormat:@"%d",score] forState: UIControlStateNormal];
            //self.panelView.userInteractionEnabled = YES;//恢复选择面板的使用
            //自动进入下一题
            if(self.index < self.pictureInfo.count - 1)
                [self performSelector:@selector(btnNextQ) withObject:nil afterDelay:1.0];
            return;
        }else{
            //[strAns setString:@""];
            //扣分
            int score = [self.coin.titleLabel.text intValue];//使用intValue 转成int
            score -= 500;
            [self.coin setTitle:[NSString stringWithFormat:@"%d",score] forState: UIControlStateNormal];
            //更改字体颜色
            [self  setAllBtnColor:[UIColor redColor]];
            //通知错误
        }
    }
}

-(void)resetAnswer:(UIButton *)sender{
    [self setAllBtnColor:[UIColor blackColor]];
    self.panelView.userInteractionEnabled = YES;
    [sender setTitle:nil forState:UIControlStateNormal];
    for (UIButton *btn in self.panelView.subviews) {
        if(btn.tag == sender.tag)
        {
            btn.hidden = NO;
            break;
        }
    }
}

-(BOOL)isCheckAnswer:(NSString *)comp{
    PictureInfo *picinfo = [[PictureInfo alloc] init];
    picinfo = self.pictureInfo[self.index];
    if([comp isEqualToString:picinfo.answer])
        return YES;
    return NO;
}

//设置所有按钮的颜色
-(void)setAllBtnColor:(UIColor *) color{
    for (UIButton *btn in self.answerview.subviews) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
}

@end
