//
//  ESInfoViewController.m
//  EskyApp
//
//  Created by jason on 14-1-4.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESInfoViewController.h"

#import "ESShowEditorCell.h"
#import "ESExpertCommentCell.h"
#import "ESShowCommentNumber.h"
#import "ESEditorSectionView.h"
#import "ESShowSendCommentCell.h"
#import "ESShowCommentCell.h"

#import "CSAnimation.h"

#import "CLImageEditor.h"


@interface ESInfoViewController ()<CLImageEditorDelegate, CLImageEditorThemeDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (strong, nonatomic) IBOutlet UITableView *infoCurrentTable;
@property (weak,   nonatomic) IBOutlet HFCycleScrollView *cycleView;
@property (assign, nonatomic) BOOL isResetCellHight;

@end

@implementation ESInfoViewController

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
    [self changeStatusBackground];

    // Do any additional setup after loading the view from its nib.
    
    self.title = @"详情";
    
    
    _cycleView.delegate = self;
    _cycleView.datasource = self;
    _cycleView.alpha = 0;

   // [_cycleView addSubview:_infoCurrentTable];
    [self performSelector:@selector(animationShow) withObject:nil afterDelay:.1];
    
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];

}

-(void)animationShow
{
    [_cycleView reloadData];
    Class <CSAnimation> class = [CSAnimation classForAnimationType:CSAnimationTypeZoomOut];
    [class performAnimationOnView:_cycleView duration:.6 delay:.1];
}


#pragma mark -  scrollViewDelegate

-(void)scrollToCurrentIndex:(NSInteger)index
{
    NSLog(@"#######%d",index);
    _isResetCellHight = NO;
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

#pragma mark -cycle delegate


- (NSInteger)numberOfPages
{
    return 5;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
  UITableView *infoTable =  [[UITableView alloc] initWithFrame:CGRectMake(0, 0,_cycleView.frame.size.width,_cycleView.frame.size.height )];
    infoTable.delegate = self;
    infoTable.dataSource = self;
    infoTable.backgroundColor = [UIColor clearColor];
    infoTable.alwaysBounceVertical = YES;
    infoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    infoTable.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    return infoTable;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [super touchesBegan:touches withEvent:event];
//    //my code
//}

#pragma mark -tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section ==1){
        return 1;
    }else
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
//            if (_isResetCellHight) {
//                return 386;
//            }
            return 336;
        }
    }else if(indexPath.section == 1){
            return 188;
    }else{
        if (indexPath.row != 0) {
            return 50;
        }
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        ESEditorSectionView *view = [ESEditorSectionView viewFromXib];
        return view;
    }
    if (section == 1) {
        ESShowCommentNumber *view = [ESShowCommentNumber viewFromXib];
        view.infoTextLabel.text = @"专家点评";
        return view;
    }
    if (section == 2) {
        ESShowCommentNumber *view = [ESShowCommentNumber viewFromXib];
        view.infoTextLabel.text = @"3条评论";
        return view;
    }
    return Nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 44;
    }
    return 29;
//    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            ESShowEditorCell *cell = [ESShowEditorCell cellFromXib];
            _isResetCellHight = YES;
            cell.testImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",rand()%10]];
            __weak __typeof(self)weakSelf = self;
            __weak  ESShowEditorCell *weakCell = cell;
            cell.shareBlock =^(id userInfo){
                NSLog(@"#####");
                [weakSelf  customShareMenuClickHandler:nil];
            };
            cell.loveBlock =^(id userInfo){
               weakCell.loveCountLabel.text = [NSString stringWithFormat:@"%d",[weakCell.loveCountLabel.text intValue]+1];
            };
            
            return cell;
        }

    }
    else if(indexPath.section == 1)
    {
            ESExpertCommentCell *cell = [ESExpertCommentCell cellFromXib];
            cell.starts.rating = rand()%5;
            return cell;
    }else{
        if (indexPath.row == 0) {
            ESShowSendCommentCell *cell = [ESShowSendCommentCell cellFromXib];
            return cell;
        }else{
            ESShowCommentCell *cell = [ESShowCommentCell cellFromXib];
            return cell;
        }
    }

    return Nil;
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
