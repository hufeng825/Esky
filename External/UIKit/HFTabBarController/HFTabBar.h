//
//  HFTabBar.h
//  HFTabBarController
//
//  Created by jason on 13-12-17.
//  Copyright (c) 2013年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTabBarItem.h"

#define kHFTabBarNotificationFlag @"kHFTabBarNotification"

@class HFTabBarIndex;

@interface HFTabBar : UIView

@property(nonatomic,assign)  NSUInteger currentSelectIndex;

- (void)selectItemAtIndex:(NSUInteger)index;

- (void)deselectSelectedItemWithOut:(NSUInteger)index;

- (void)addCallBack;

@end



@interface  HFTabBarIndex: NSObject

@property (nonatomic,assign)NSUInteger fromIndex;
@property (nonatomic,assign)NSUInteger toIndex;

+(HFTabBarIndex *)initWithFromIndex:(NSUInteger)fromindex toIndex:(NSUInteger)toindex;

@end