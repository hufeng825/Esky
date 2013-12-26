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


#define ITEM_SPACING 265


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
    carousel.type = iCarouselTypeRotary;
//    CGSize offset = CGSizeMake(0.0f,100);
//    carousel.contentOffset = offset;
    carousel.scrollSpeed = 0.28;
    [carousel reloadData];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(step) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

}


- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    if(!carousel.dragging)
    {
        [[self nextResponder]touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
    //NSLog(@"MyScrollView touch Began");
}
   
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    if(!carousel.dragging)
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
}

-(void)step
{
    if (carousel.scrolling) {
        return;
    }else{
        [carousel scrollToItemAtIndex:(carousel.currentItemIndex+1)%carousel.numberOfItems duration:1];
    }
}
#pragma mark -

- (IBAction)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
    [self.dynamicsDrawerViewController toggleLeftAnimated:YES];
}



- (IBAction)switchCarouselType
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择类型" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"直线", @"圆圈", @"反向圆圈", @"圆桶", @"反向圆桶", @"轮子",@"反向轮子",@"封面展示", @"封面展示2",@"时光机",@"反向时光机",nil];
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
    return 5;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
//- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index
{
//    UIView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",index]]];
    if (view == nil)
    {
        view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, ITEM_SPACING, 425)];
    }
    ((UIImageView *)view).image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",index]];
    return view;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return YES;
        }
//        case iCarouselOptionFadeMax:
//        {
//            if (carousel.type == iCarouselTypeCustom)
//            {
//                return 0.0f;
//            }
//            return value;
//        }
//        case iCarouselOptionArc:
//        {
//            return 2 * M_PI * _arcSlider.value;
//        }
//        case iCarouselOptionRadius:
//        {
//            return value * _radiusSlider.value;
//        }
        case iCarouselOptionTilt:
        {
            return .75;
        }
        case iCarouselOptionSpacing:
        {
            return value * 1.1;
        }
        default:
        {
            return value;
        }
    }
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
