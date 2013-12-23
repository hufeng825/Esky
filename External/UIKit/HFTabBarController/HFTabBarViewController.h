//
//  HFTabBarViewController.h
//  HFTabBarController
//
//  Created by jason on 13-12-19.
//  Copyright (c) 2013年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFTabBarControllerDelegate.h"
#import "HFTabBar.h"


@interface HFTabBarViewController : UIViewController<UINavigationControllerDelegate>

/** An array of the view controllers displayed by the tab bar */
@property (nonatomic, copy) NSArray *subViewControllers;

/** The index of the view controller associated with the currently selected tab item. */
@property (nonatomic, assign) NSInteger selectedIndex;

/** The view controller associated with the currently selected tab item. */
@property (nonatomic, weak) UIViewController *selectedViewController;

/** The tab bar controller’s delegate object. */
@property (nonatomic, weak) id<HFTabBarControllerDelegate> delegate;

/** The tableView used to display all tab bar elements */
 @property (nonatomic, weak) IBOutlet  HFTabBar *tabBar;
/** The postion of the tabBar on screen (top/left/bottom/right) */

/** The animation used when changing selected tabBarItem, default: none */
//@property (nonatomic, assign) HFTabBarControllerAnimation animation;
/** The duration of the used animation, only taken into account when animation is different from none */
@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, assign) BOOL tabBarHidden;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;


@end
