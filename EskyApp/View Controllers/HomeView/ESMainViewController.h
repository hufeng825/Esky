//
//  ESViewController.h
//  ESFrame
//
//  Created by jason on 13-10-22.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESBaseViewController.h"
#import "MSDynamicsDrawerViewController.h"

#import "UIWebImageView.h"

@interface ESMainViewController : ESBaseViewController

@property (nonatomic, weak) MSDynamicsDrawerViewController *dynamicsDrawerViewController;

- (id)initDrawerViewController:(MSDynamicsDrawerViewController *)dynamicsDrawerViewController;

- (IBAction)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender;

@end