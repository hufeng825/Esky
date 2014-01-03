//
//  iCarouselTypeRotary.m
//  EskyApp
//
//  Created by jason on 13-12-26.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESShowCenterViewController.h"
#import "ESTalentPictureItem.h"

#import "ESShowTimeCell.h"
#import "ESShowCell.h"
#import "ESCommentCell.h"


@interface ESShowCenterViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet ESMenuTabBar *test;


@property (strong, nonatomic) IBOutlet UITableView *showTimeTableView;
@property (strong, nonatomic) IBOutlet UITableView *showTableView;
@property (strong, nonatomic) IBOutlet UITableView *commentTableView;

@end

@implementation ESShowCenterViewController

@synthesize showTimeTableView,showTableView,commentTableView;

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
    [_scrollView setContentOffset:CGPointMake(index*_scrollView.width, 0) animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _test.delegate = self;
    
    [_test  initItemsTitles:@[
      @{@"Title":@"最新", @"EnglishTitle":@"SHOW TIME"},
      @{@"Title":@"达人", @"EnglishTitle":@"SHOW"},
      @{@"Title":@"点评", @"EnglishTitle":@"FASHION"},
    ]];
    
    NSArray *array = @[showTimeTableView,showTableView,commentTableView];
    for (int i=0; i<3; i++) {
        UITableView *tabView = [array objectAtIndex:i];
        tabView.frame =CGRectMake(i*_scrollView.width, 0, _scrollView.width, _scrollView.height);
        [_scrollView addSubview:tabView];
    }
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.width*3, _scrollView.height)];

//    [_test1 setStyle:NormalPictureStyle];
//    
//    _test2.block =^{
//        NSLog(@"yui");
//        [self buttonClicked:_test2];
//    };
    
}

- (IBAction)buttonClicked:(id)sender {
    UIView *senderView = (UIView*)sender;
    if (![senderView isKindOfClass:[UIView class]])
        return;
    
    UIView *icon =sender;
    
    //move along the path
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:icon.center];
    NSLog(@"%f %f",[senderView convertPoint:icon.center fromView:self.view].x,[senderView convertPoint:icon.center fromView:self.view].y);
    [movePath addQuadCurveToPoint:[senderView convertPoint:icon.center toView:self.view]
                     controlPoint:CGPointMake([senderView convertPoint:icon.center fromView:self.view].x ,0)];
    
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = NO;
    
    
    //Scale Animation
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1,1, 1)];
    scaleAnim.removedOnCompletion = YES;
    
    

    
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim, nil];
    animGroup.duration = 1.0;
    [icon.layer addAnimation:animGroup forKey:nil];
    
    // create timer with time of animation to change the image.
    
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


#pragma mark -tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == showTableView ) {
        static NSString *showidentificer = @"ESShowCell";
        ESShowCell *cell = [tableView dequeueReusableCellWithIdentifier:showidentificer];
        if (cell == nil) {
            cell = [ESShowCell cellFromXib];
        }
        return cell;
    }else if (tableView == showTimeTableView ){
       static NSString *showTimeidentificer = @"ESShowTimeCell";
        ESShowTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:showTimeidentificer];
        if (cell == nil) {
            cell = [ESShowTimeCell cellFromXib];
        }
        return cell;
    }else if (tableView == commentTableView){
       static NSString *commentidentificer = @"ESCommentCell";
        ESCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentidentificer];
        if (!cell) {
            cell = [ESCommentCell cellFromXib];
        }
        [[cell starts]setRating:3];
        return cell;
    }
    
    return Nil;
    
//    BalancePlanManageInformation *model = [self.listArray objectAtIndexSafe:indexPath.row];
//    [cell setupDatas:model];
//    
//    //变更按钮点击
//    [cell setChangeBtnClickBlock:^(BalancePlanManageInformation *data) {
//        [self showChangeViewController:data];
//    }];
//    
//    //终止按钮点击
//    [cell setStopBtnClickBlock:^(BalancePlanManageInformation *data) {
//        [self showStopViewController:data];
//        _selectedStopPlanIndex = indexPath.row;
//    }];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    BalancePlanManageInformation *model = [self.listArray objectAtIndex:indexPath.row];
//    BalancePlanManageDetailViewController *detailVC = [[BalancePlanManageDetailViewController alloc] init];
//    [detailVC setBalancePlanManageInfoModel:model];
//    [self.navigationController pushViewController:detailVC animated:YES];
//    [[BalancePlanTabBarViewController GetInstance] hideTabBarAnimated:YES];
//    [detailVC release];
}

@end
