//
//  HFTabBarItem.m
//  HFTabBarController
//
//  Created by jason on 13-12-17.
//  Copyright (c) 2013年 taobao. All rights reserved.
//

#import "HFTabBarItem.h"

@interface HFTabBarItem()

@end

@implementation HFTabBarItem


@synthesize userInfo,block;



- (void)setBlock:(TabItemClickBlock)newBlock
{
    [self addTarget:self action:@selector(doTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    if (block != newBlock) {
//        [block release]; ARC not
        block = [newBlock copy];
        }
}

- (void)doTouchUpInside:(id)sender {
    
    if (block)
    {
        block(self.tag,userInfo);
       // self.isActive = !self.isActive;
    }
}

- (void)setIsActive:(BOOL)active
{
    if (self.isActive != active) {
        _isActive = active;
        self.selected = active;
    }
}

@end
