//
//  MLLeftDockMenu.m
//  newFinal
//
//  Created by 李明禄 on 15/12/12.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLLeftDockMenu.h"

@implementation MLLeftDockMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    }
    return self;
}

@end
