//
//  ESViewController.h
//  EskyApp
//
//  Created by jason on 14-1-26.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESBaseViewController.h"
#import "YASlidingViewController.h"
@interface ESFollowViewController : ESBaseViewController

@property (nonatomic, weak) YASlidingViewController *dynamicsDrawerViewController;

-(id)initDrawerViewController:(YASlidingViewController *)dynamicsDrawerViewController;

- (IBAction)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender;

@end
