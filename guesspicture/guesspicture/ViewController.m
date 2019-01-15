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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self pictureInfo];
}


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

@end
