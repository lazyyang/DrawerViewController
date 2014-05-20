//
//  ZYDropCustomView.m
//  DrawerDemo
//
//  Created by 杨争 on 5/20/14.
//  Copyright (c) 2014 LazyYang. All rights reserved.
//

#import "ZYDropCustomView.h"

@implementation ZYDropCustomView

- (void)drawRect:(CGRect)rect
{
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 0.7f;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = shadowPath.CGPath;
}

@end
