//
//  FAViewController.m
//  FAFrame
//
//  Created by jason on 13-10-22.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESMainViewController.h"

#import "ESConfig.h"

#import "ESChoseModuleViewController.h"

#import "ESLoginViewController.h"

#import "UIViewController+SlidingView.h"


@interface ESMainViewController ()
@property (weak, nonatomic) IBOutlet UIWebImageView *testimg;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@end

@implementation ESMainViewController

-(id)initDrawerViewController:(MSDynamicsDrawerViewController *)dynamicsDrawerViewController
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.dynamicsDrawerViewController = dynamicsDrawerViewController;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
    [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionLeft animated:YES allowUserInterruption:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
