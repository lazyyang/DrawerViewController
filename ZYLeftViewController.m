//
//  ZYLeftViewController.m
//  DrawerDemo
//
//  Created by 杨争 on 5/20/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import "ZYLeftViewController.h"
#import "ZYDrawerViewController.h"
#import "ZYCenterOneViewController.h"
#import "ZYCenterTwoViewController.h"
#import "ZYCenterThreeViewController.h"

@interface ZYLeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *itemsArray;

@end

@implementation ZYLeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return   self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = self.itemsArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ZYCenterOneViewController *vc = [[ZYCenterOneViewController alloc]init];
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.drawer changeCenterViewController:navVC];
        [self.drawer closeDrawer];
    }
    else if (indexPath.row == 1){
        ZYCenterTwoViewController *vc = [[ZYCenterTwoViewController alloc]init];
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.drawer changeCenterViewController:navVC];
        [self.drawer closeDrawer];
    }
    else if (indexPath.row == 2){
        ZYCenterThreeViewController *vc = [[ZYCenterThreeViewController alloc]init];
        UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.drawer changeCenterViewController:navVC];
        [self.drawer closeDrawer];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _itemsArray = @[@"红色",@"蓝色",@"黄色"];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableView.frame = CGRectMake(0, 0, 200, self.tableView.frame.size.height);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
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
