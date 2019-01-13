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

@property(nonatomic, strong) PictureInfo *pictureInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


-(PictureInfo *)pictureInfo{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"pictureInfo" ofType:@"plist"];
    
}

@end
