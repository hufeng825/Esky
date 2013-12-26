//
//  ESViewController.h
//  ESFrame
//
//  Created by jason on 13-10-22.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESBaseViewController.h"
#import "YASlidingViewController.h"
#import "iCarousel.h"
#import "UIWebImageView.h"

@interface ESMainViewController : ESBaseViewController <iCarouselDataSource,iCarouselDelegate,UIActionSheetDelegate>

@property (nonatomic, weak) YASlidingViewController *dynamicsDrawerViewController;

- (id)initDrawerViewController:(YASlidingViewController *)dynamicsDrawerViewController;

- (IBAction)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender;

- (IBAction)switchCarouselType;

@end