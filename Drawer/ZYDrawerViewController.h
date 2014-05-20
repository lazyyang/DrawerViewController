//
//  ZYDrawerViewController.h
//  DrawerDemo
//
//  Created by 杨争 on 5/20/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYDrawerViewController;

@protocol ZYDrawerControllerPressenting <NSObject>

@optional


/**
 *  drawerController will open
 *
 *  @param drawerController
 */
- (void)drawerControllerWillOpen:(ZYDrawerViewController *)drawerController;



/**
 *  drawerController will close
 *
 *  @param drawerController
 */
- (void)drawerControllerWillClose:(ZYDrawerViewController *)drawerController;



/**
 *  drawerController did close
 *
 *  @param drawerController
 */
- (void)drawerControllerDidClose:(ZYDrawerViewController *)drawerController;



/**
 *  drawerController did open
 *
 *  @param drawerController
 */
- (void)drawerControllerDidOpen:(ZYDrawerViewController *)drawerController;

@end

@interface ZYDrawerViewController : UIViewController


/**
 *  open Drawer menu
 */
- (void)openDrawer;



/**
 *  close Drawer menu
 */
- (void)closeDrawer;



/**
 *  change the current CenterViewController
 *
 *  @param centerViewController
 */
- (void)changeCenterViewController:(UIViewController *)centerViewController;




/**
 *  init the controller with leftViewController and centerViewController
 *
 *  @param leftViewController   menu
 *  @param centerViewController content
 *
 *  @return self
 */
- (id)initWithLeftViewController:(UIViewController *)leftViewController centerViewController:(UIViewController *)centerViewController;

@end
