//
//  ZYCenterOneViewController.m
//  TheDrawerDemo
//
//  Created by 杨争 on 5/20/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import "ZYCenterOneViewController.h"
#import "ZYNextViewController.h"
#import "ZYDrawerViewController.h"

@interface ZYCenterOneViewController ()

@end

@implementation ZYCenterOneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)btnClicked:(UIButton *)button
{
    NSLog(@"=====%@",self.navigationController.topViewController);
    ZYNextViewController *vc = [[ZYNextViewController alloc]init];
    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc  animated:YES];
    vc = nil;
}

- (void)barItemClicked
{
    NSLog(@"返回");
    ZYDrawerViewController *drawer = (ZYDrawerViewController *)self.parentViewController.parentViewController;
    if ([drawer performSelector:@selector(openDrawer)]) {
        [drawer openDrawer];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"红色";
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 100, 100, 100);
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"下一个页面" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(barItemClicked)];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
