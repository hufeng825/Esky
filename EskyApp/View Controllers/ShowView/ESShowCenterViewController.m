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


#import "ESInfoViewController.h"
#import "CLImageEditor.h"
#import "ESPublishViewController.h"


@interface ESShowCenterViewController ()<CLImageEditorDelegate, CLImageEditorThemeDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate>

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


- (IBAction)pushedNewBtn
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    [sheet showInView:self.view.window];
}
#pragma mark- ImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    editor.delegate = self;
    
    [picker pushViewController:editor animated:YES];
}
#pragma mark- Actionsheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==actionSheet.cancelButtonIndex){
        return;
    }
    
    UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if([UIImagePickerController isSourceTypeAvailable:type]){
        if(buttonIndex==0 && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            type = UIImagePickerControllerSourceTypeCamera;
        }
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = NO;
        picker.delegate   = self;
        picker.sourceType = type;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - Imageeditfinsh Delegate

- (void)imageEditor:(CLImageEditor*)editor didFinishEdittingWithImage:(UIImage*)image
{
    [editor dismissViewControllerAnimated:YES completion:^{
        ESPublishViewController *vc = [[ESPublishViewController alloc]initWithImage:image];
        UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.navigationController presentViewController:nv animated:YES completion:^{
            
        }];

    }];
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
    [UIView animateWithDuration:0.5f delay:0 options:(
                                                      UIViewAnimationOptionAllowUserInteraction |
                                                      UIViewAnimationOptionBeginFromCurrentState |
                                                      UIViewAnimationOptionCurveEaseInOut
                                                      ) animations: ^ {
        [_scrollView setContentOffset:CGPointMake(index*_scrollView.width, 0) animated:NO];
    } completion:nil];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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

#pragma mark - scrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        [_test selectMenuItemAtIndex:page];
    }
   
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

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
        [[cell starts]setRating:rand()%5];
        cell.editorImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"head%d.png",rand()%6]];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ESInfoViewController *vc = [[ESInfoViewController alloc] initWithNibName:@"ESInfoViewController" bundle:nil];
    [vc.navigationController setNavigationBarHidden:NO];
    [self.navigationController pushViewController:vc animated:YES];
//    BalancePlanManageInformation *model = [self.listArray objectAtIndex:indexPath.row];
//    BalancePlanManageDetailViewController *detailVC = [[BalancePlanManageDetailViewController alloc] init];
//    [detailVC setBalancePlanManageInfoModel:model];
//    [self.navigationController pushViewController:detailVC animated:YES];
//    [[BalancePlanTabBarViewController GetInstance] hideTabBarAnimated:YES];
//    [detailVC release];
}

@end
