//
//  ZYDrawerViewController.m
//  DrawerDemo
//
//  Created by 杨争 on 5/20/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import "ZYDrawerViewController.h"
#import "ZYDropCustomView.h"
#import "ZYCustomViewController.h"

static NSTimeInterval animationTime = 0.2f;

static CGFloat const DrawerLeftWidth = 240.0f;

static CGFloat const ScreenWidth = 320.0f;

typedef NS_ENUM(NSUInteger, ZYDrawerControllerState)
{
    ZYDrawerControllerStateClosed = 0,
    
    ZYDrawerControllerStateClosing,
    
    ZYDrawerControllerStateOpened,
    
    ZYDrawerControllerStateOpening
};

@interface ZYDrawerViewController ()<UIGestureRecognizerDelegate>

/**
 *  leftViewController
 */
@property (nonatomic,strong) UIViewController *leftViewController;
/**
 *  centerViewController
 */
@property (nonatomic,strong) UIViewController *centerViewController;
/**
 *  lelftView菜单
 */
@property (nonatomic,strong) UIView *leftView;
/**
 *  centerView
 */
@property (nonatomic,strong) UIView *centerView;
/**
 *  ZYDrawerController的状态
 */
@property (nonatomic,assign) ZYDrawerControllerState currentState;
/**
 *  手势的起点x坐标
 */
@property (nonatomic,assign) CGFloat startX;
/**
 *  若centerViewController为UINavigationController类型的，则rootViewController为其rootViewController
 */
@property (nonatomic,assign) UIViewController *rootViewController;

@property (nonatomic,strong) UIPanGestureRecognizer *panGes;


@property (nonatomic,strong) UITapGestureRecognizer *tapGes;


@end

@implementation ZYDrawerViewController

#pragma mark -init
- (id)initWithLeftViewController:(UIViewController *)leftViewController centerViewController:(UIViewController *)centerViewController
{
    self = [super init];
    if (self) {
        self.leftViewController = leftViewController;
        ((ZYCustomViewController *)self.leftViewController).drawer = self;
        self.centerViewController = centerViewController;
        if ([self.centerViewController isKindOfClass:[UINavigationController class]]) {
            self.rootViewController = ((UINavigationController *)self.centerViewController).topViewController;
        }
    }
    return self;
}

#pragma mark -changeCenterViewController
- (void)changeCenterViewController:(UIViewController *)centerViewController
{
    [self.centerViewController.view removeFromSuperview];
    [self.centerViewController removeFromParentViewController];
    
    self.centerViewController = centerViewController;
    if ([self.centerViewController isKindOfClass:[UINavigationController class]]) {
        self.rootViewController = ((UINavigationController *)self.centerViewController).topViewController;
    }
    [self addCenterViewController];
}

#pragma mark -addCenterViewController
- (void)addCenterViewController
{
    [self addChildViewController:self.centerViewController];
    self.centerViewController.view.frame = self.view.bounds;
    [self.centerView addSubview:self.centerViewController.view];
}

#pragma mark -addLeftViewController
- (void)addLeftViewController
{
    [self addChildViewController:self.leftViewController];
    self.leftViewController.view.frame = self.view.bounds;
    [self.leftView addSubview:self.leftViewController.view];
}

#pragma mark -open Drawer
- (void)openDrawer
{
    [UIView animateWithDuration:animationTime animations:^{
        self.centerView.frame = CGRectMake(DrawerLeftWidth, 0, self.centerView.frame.size.width, self.centerView.frame.size.height);
        self.currentState = ZYDrawerControllerStateOpened;
        self.centerViewController.view.userInteractionEnabled = NO;
        self.tapGes.enabled = YES;
    }];
}

#pragma mark -close Drawer
- (void)closeDrawer
{
    [UIView animateWithDuration:animationTime animations:^{
        self.centerView.frame = CGRectMake(0, 0, self.centerView.frame.size.width, self.centerView.frame.size.height);
        self.currentState = ZYDrawerControllerStateClosed;
        self.centerViewController.view.userInteractionEnabled = YES;
        self.tapGes.enabled = NO;
    }];
}

#pragma mark -tapGestureRecognized
- (void)tapGestureRecognized:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if ([self.centerViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVC = (UINavigationController *)self.centerViewController;
        if (navVC.topViewController != self.rootViewController) {
            return;
        }
    }
    
    if (self.currentState == ZYDrawerControllerStateClosed) {
        [self openDrawer];
    }
    else{
        [self closeDrawer];
    }
    
}

#pragma mark -panGestureRecognized
- (void)panGestureRecognized:(UIPanGestureRecognizer *)panGes
{
    if ([self.centerViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navVC = (UINavigationController *)self.centerViewController;
        if (navVC.topViewController != self.rootViewController) {
            return;
        }
    }

    static BOOL noOpenAndClose = NO;//既不打开也不关闭Drawer
    CGPoint pointer = [panGes locationInView:self.centerView];
    if (panGes.state == UIGestureRecognizerStateBegan) {
        //开始
        self.startX = pointer.x;
        NSLog(@"startX");
    }
    else if (panGes.state == UIGestureRecognizerStateChanged){
        NSLog(@"改变");
        CGRect frame = self.centerView.frame;
        if (pointer.x - self.startX < 0) {//向左滑动
            if (frame.origin.x == 0) {
                noOpenAndClose = YES;
            }
            else{
                frame.origin.x += pointer.x - self.startX;
                if (frame.origin.x <= 0) {
                    frame.origin.x = 0.0f;
                }
                noOpenAndClose = NO;
            }
        }
        else if (pointer.x - self.startX > 0){//向右滑动
            if (frame.origin.x == ScreenWidth) {
                noOpenAndClose = YES;
            }
            else{
                frame.origin.x += pointer.x - self.startX;
                if (frame.origin.x >= ScreenWidth) {
                    frame.origin.x = ScreenWidth;
                }
                noOpenAndClose = NO;
            }
        }
        self.centerView.frame = frame;
    }
    else if (panGes.state == UIGestureRecognizerStateEnded){
        if (self.currentState == ZYDrawerControllerStateClosed) {
            if (noOpenAndClose == NO) {
                if (self.centerView.frame.origin.x >= 100) {
                    [self openDrawer];
                }
                else{
                    [self closeDrawer];
                }
            }
        }
        else if (self.currentState){
            if (noOpenAndClose == NO) {
                if (self.centerView.frame.origin.x <= DrawerLeftWidth - 50.0f) {
                    [self closeDrawer];
                }
                else{
                    [self openDrawer];
                }
            }
        }
    }
    else if (panGes.state == UIGestureRecognizerStateCancelled){
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _leftView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    _centerView = [[ZYDropCustomView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:_leftView];
    [self.view addSubview:_centerView];
    
    self.centerView.backgroundColor = [UIColor redColor];
    
    _panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognized:)];
    self.panGes.delegate = self;
    self.panGes.delaysTouchesBegan = YES;
    self.panGes.cancelsTouchesInView = NO;
    [self.centerView addGestureRecognizer:self.panGes];
    
    _tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognized:)];
    self.tapGes.enabled = NO;
    [self.centerView addGestureRecognizer:self.tapGes];
    
    [self addLeftViewController];
    [self addCenterViewController];
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
