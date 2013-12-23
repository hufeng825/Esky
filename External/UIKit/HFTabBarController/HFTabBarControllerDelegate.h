//
//  HFTabBarControllerDelegate.h
//  HFTabBarController
//
//  Created by jason on 13-12-17.
//  Copyright (c) 2013年 taobao. All rights reserved.
//



#import <Foundation/Foundation.h>

@class HFTabBarIndex;
@class HFTabBarViewController;

@protocol HFTabBarControllerDelegate <NSObject>

@optional

/** Asks the delegate whether the specified view controller should be made active. */

- (void)tabBarController:(HFTabBarViewController *)tabBarController
    selectViewController:(UIViewController *)viewController
                 atIndex:(HFTabBarIndex *)index;



@end
