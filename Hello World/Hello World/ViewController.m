//
//  ViewController.m
//  Hello World
//
//  Created by Paul on 2018/12/5.
//  Copyright © 2018 Dingzhijian. All rights reserved.
//

#import "ViewController.h"
#import "Check.h"

@interface ViewController ()

//添加文本框属性
@property(nonatomic,weak) IBOutlet UITextField *num1TextField;
//添加第二个文本框
@property(nonatomic,weak) IBOutlet UITextField *num2TextField;

//添加label
@property(nonatomic,weak) IBOutlet UILabel *label;

//qq账号文本框
@property(nonatomic,weak) IBOutlet UITextField *name;
//qq密码文本框
@property(nonatomic,weak) IBOutlet UITextField *psw;


-(IBAction)cacultor;
-(IBAction)logIn;
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

-(IBAction)cacultor{
    NSString *num1Text =  self.num1TextField.text;
    NSString *num2Text = self.num2TextField.text;
    int result = num1Text.intValue + num2Text.intValue;
    self.label.text = [NSString stringWithFormat:@"%d",result];
    //退出键盘
    
    //[self.num1TextField resignFirstResponder];
    //[self.num2TextField resignFirstResponder];
    
    //另一种方法
    [self.view endEditing:YES];
}

-(IBAction)logIn{
    NSString *nameText = self.name.text;
    NSString *logInText = self.psw.text;
    Check * check = [[Check alloc] init];
    if([check checkNum:nameText] == YES){
        NSLog(@"QQ账号为： %@", nameText);
    }else{
        //NSLog(@"");
        //exit(0);
        //abort();
        return;
    }
    if([check checkPsw:logInText] == YES)
        NSLog(@"QQ密码为： %@",logInText);
    [self.view endEditing:YES];
}
       

@end
