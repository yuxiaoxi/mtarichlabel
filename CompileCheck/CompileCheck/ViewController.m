//
//  ViewController.m
//  CompileCheck
//
//  Created by Figo on 2017/6/23.
//  Copyright © 2017年 MTA. All rights reserved.
//

#import "ViewController.h"
#import "MTARichLabel.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *aaLabel;

@property (nonatomic, strong) MTARichLabel *richLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _aaLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    _aaLabel.textColor = [UIColor redColor];
    _aaLabel.text = @"aaaaaaaaaa";
    [self.view addSubview:_aaLabel];
    
    _richLabel = [[MTARichLabel alloc]initWithFrame:CGRectMake(100, 200, 250, 100)];
    _richLabel.numberOfLines = 3;
    _richLabel.textColor = [UIColor blackColor];
    _richLabel.text = @"近七天收到<font color='#ff0000'>我是高亮的字体</font>条好评,,,,这个是个粗体啊<b>我是个加粗的文字</b>条好评";
    [self.view addSubview:_richLabel];
    
}





@end
