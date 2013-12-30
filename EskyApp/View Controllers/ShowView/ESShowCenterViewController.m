//
//  iCarouselTypeRotary.m
//  EskyApp
//
//  Created by jason on 13-12-26.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESShowCenterViewController.h"


@interface ESShowCenterViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet ESMenuTabBar *test;

@end

@implementation ESShowCenterViewController

-(id)initDrawerViewController:(YASlidingViewController *)dynamicsDrawerViewController
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.dynamicsDrawerViewController = dynamicsDrawerViewController;
    }
    return self;
}

#pragma mark -

- (IBAction)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
    [self.dynamicsDrawerViewController toggleLeftAnimated:YES];
}


#pragma mark - itemDelegate
-(void)itemClicked:(NSInteger)index
{
    NSLog(@"%d",index);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _test.delegate = self;
    
    for (int i=0; i<3; i++) {
        UIView *vc = [[UIView alloc]initWithFrame:CGRectMake(i*_scrollView.width, 0, _scrollView.width, _scrollView.height)];
        vc.backgroundColor = RGB(rand()%255, rand()%255, rand()%255);
        [_scrollView addSubview:vc];
    }
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.width*3, _scrollView.height)];


}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [_test selectMenuItemAtIndex:page];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
