//
//  MyViewController.m
//  movienext
//
//  Created by 风之翼 on 15/2/27.
//  Copyright (c) 2015年 redianying. All rights reserved.
//

#import "MyViewController.h"
#import "Constant.h"
#import "SettingViewController.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor yellowColor];
    [self createNavigation];
}
-(void)createNavigation
{
    self.navigationController.navigationItem.title=@"我的";
    UIButton  *button=[UIButton buttonWithType:UIButtonTypeCustom];
    //[button setTitle:@"设置" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(kDeviceWidth-30, 10, 18, 18);
    [button addTarget:self action:@selector(GotoSettingClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem  *barButton=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=barButton;
}
-(void)GotoSettingClick:(UIButton  *) button
{
    
    [self.navigationController pushViewController:[SettingViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
