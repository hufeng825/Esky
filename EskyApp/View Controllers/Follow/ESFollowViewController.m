//
//  ESViewController.m
//  EskyApp
//
//  Created by jason on 14-1-26.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESFollowViewController.h"
#import "ACTimeScroller.h"
#import "ESFollowImageViewCell.h"
#import "ESFollowCell.h"
#import "ESFollowSectionView.h"
#import <ShareSDK/ShareSDK.h>


@interface ESFollowViewController ()<ACTimeScrollerDelegate,UINavigationControllerDelegate>
{
    ACTimeScroller *_timeScroller;
    NSMutableArray *_datasource;
}
@end

@implementation ESFollowViewController


-(id)initDrawerViewController:(YASlidingViewController *)dynamicsDrawerViewController
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.dynamicsDrawerViewController = dynamicsDrawerViewController;
    }
    return self;
}

- (IBAction)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
    [self.dynamicsDrawerViewController toggleLeftAnimated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];
    [self setupDatasource];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupDatasource
{
    _datasource = [NSMutableArray new];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDate *today = [NSDate date];
    NSDateComponents *todayComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    for (int i = [todayComponents day]; i >= -15; i--)
    {
        [components setYear:[todayComponents year]];
        [components setMonth:[todayComponents month]];
        [components setDay:i];
        [components setHour:arc4random() % 23];
        [components setMinute:arc4random() % 59];
        
        NSDate *date = [calendar dateFromComponents:components];
        [_datasource addObject:date];
    }

}


#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0) {
                return 210;
            }else{
            return 96;
        }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
        ESFollowSectionView *view = [ESFollowSectionView viewFromXib];
//        view.infoTextLabel.text = @"专家点评";
        return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 44;
    //    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *followImageidentificer = @"ESFollowImageViewCell";
        ESFollowImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:followImageidentificer];
        if (!cell) {
            cell = [ESFollowImageViewCell cellFromXib];
            //                cell.testImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",1]];
        }
        cell.contextImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"follow%d.jpg",rand()%3]];
        return cell;
    }
    else if (indexPath.row == 1) {
        static NSString * followCellidentificer= @"ESFollowCell";
        ESFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:followCellidentificer];
        if (!cell) {
            cell = [ESFollowCell cellFromXib];
        }
        __weak __typeof(self)weakSelf = self;
        __weak  ESFollowCell *weakCell = cell;
        cell.shareBlock =^(id userInfo){
            NSLog(@"#####");
            [weakSelf  customShareMenuClickHandler:nil];
        };
        cell.loveBlock =^(id userInfo){
            weakCell.loveCountLabel.text = [NSString stringWithFormat:@"%d",[weakCell.loveCountLabel.text intValue]+1];
        };
        return cell;
    }
    return nil;
}

#pragma mark - ACTimeScrollerDelegate Methods

- (UITableView *)tableViewForTimeScroller:(ACTimeScroller *)timeScroller
{
    return [self tableView];
}

- (NSDate *)timeScroller:(ACTimeScroller *)timeScroller dateForCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    return _datasource[[indexPath section]];
}


#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timeScroller scrollViewWillBeginDragging];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_timeScroller scrollViewDidScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_timeScroller scrollViewDidEndDecelerating];
}


#pragma mark - share

- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType {
    //    [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"iPhoneNavigationBarBG.png"]];
    
    NSString *logTitleStr = @"私享家登录授权";
    [viewController.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.rightBarButtonItem = nil;
    viewController.title = logTitleStr;
    
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //    [viewController.view addSubview:button];
    
}


- (void)customShareMenuClickHandler:(UIButton *)sender
{
    //定义菜单分享列表
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeSinaWeibo, ShareTypeWeixiTimeline ,ShareTypeWeixiSession,nil];
    
    //创建分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"测试内容"
                                       defaultContent:@""
                                                image:nil
                                                title:@"时尚先生"
                                                  url:@"http://www.baidu.com"
                                          description:@"这是一条测信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //创建容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleModal
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"阿里巴巴"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"阿里巴巴"],
                                    SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                    nil]];
    
    //显示分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:authOptions
                      shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                          oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                           qqButtonHidden:NO
                                                    wxSessionButtonHidden:YES
                                                   wxTimelineButtonHidden:YES
                                                     showKeyboardOnAppear:NO
                                                        shareViewDelegate:nil
                                                      friendsViewDelegate:nil
                                                    picViewerViewDelegate:nil]
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

@end
