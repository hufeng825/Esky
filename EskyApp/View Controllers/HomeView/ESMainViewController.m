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


#define ITEM_SPACING 270


@interface ESMainViewController ()
@property (weak, nonatomic) IBOutlet UIWebImageView *testimg;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@end

@implementation ESMainViewController
@synthesize carousel;

-(id)initDrawerViewController:(YASlidingViewController *)dynamicsDrawerViewController
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.dynamicsDrawerViewController = dynamicsDrawerViewController;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    carousel.type = iCarouselTypeCylinder;
//    CGSize offset = CGSizeMake(0.0f,0);
//    carousel.contentOffset = offset;
    carousel.scrollSpeed = 0.25;
    [carousel reloadData];
//    carousel.backgroundColor = [UIColor grayColor];
    [carousel scrollByNumberOfItems:5 duration:1];

}

#pragma mark -

- (IBAction)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
    [self.dynamicsDrawerViewController toggleLeftAnimated:YES];
}



- (IBAction)switchCarouselType
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择类型" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"直线", @"圆圈", @"反向圆圈", @"圆桶", @"反向圆桶", @"封面展示", @"封面展示2", @"纸牌", nil];
    [sheet showInView:self.view];
   
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    for (UIView *view in carousel.visibleItemViews)
    {
        view.alpha = 1.0;
    }
    
    [UIView beginAnimations:nil context:nil];
    carousel.type = buttonIndex;
    [UIView commitAnimations];
    
}


#pragma mark --

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return 30;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",index]]];
    view.frame = CGRectMake(0, 0, 265, 425);
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 30;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_SPACING;
}

- (CATransform3D)carousel:(iCarousel *)_carousel transformForItemView:(UIView *)view withOffset:(CGFloat)offset
{
    view.alpha = 1.0 - fminf(fmaxf(offset, 0.0), 1.0);
    
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = self.carousel.perspective;
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0, 1.0, 0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}

#pragma mark iCarousel taps

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
//    NSNumber *item = (self.items)[index];
    NSLog(@"Tapped view number: %d", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
