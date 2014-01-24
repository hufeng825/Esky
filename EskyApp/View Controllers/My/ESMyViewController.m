//
//  ESMyViewController.m
//  EskyApp
//
//  Created by jason on 14-1-22.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESMyViewController.h"

#import "CLImageEditor.h"
#import "REDActionSheet.h"
#import "ESPublishViewController.h"
#import "UIView+Additions.h"
#import "UIScrollView+HFParallaxHeader.h"
#import "ESCommonMacros.h"
#import "ESMyMenuTabBar.h"

#import "ACTimeScroller.h"



@interface ESMyViewController ()<CLImageEditorDelegate, CLImageEditorThemeDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ESMyMenuTabBarDelegate,ACTimeScrollerDelegate>
{
    NSMutableArray *_datasource;
    ACTimeScroller *_timeScroller;
}
@property (weak,   nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImageView *headView;
@property (strong, nonatomic) UIImageView *headIcon;
@property (strong, nonatomic) UIImageView *genderView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) ESMyMenuTabBar *menutabBar;
@end

const float HeadHight = 160.f;

@implementation ESMyViewController

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
    [self setUpHeadView];
    [self setBgContentOffsetAnimation:-HeadHight];//此处防止初始化页面错位的
    _timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];
    [self setupDatasource];
    [_tableView delaysContentTouches];

}

#pragma mark - ACTimeScrollerDelegate Methods

- (UITableView *)tableViewForTimeScroller:(ACTimeScroller *)timeScroller
{
    return [self tableView];
}

- (NSDate *)timeScroller:(ACTimeScroller *)timeScroller dateForCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    return _datasource[[indexPath row]];
}


- (void) setUpHeadView
{
    self.headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,320, 160)];
    self.headIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.headView.image = [UIImage imageNamed:@"1.png"];
    [self.headView addSubview: _headIcon];
    [self.headIcon centerInSuperView];
    [self.tableView addParallaxWithView:self.headView andHeight:HeadHight];
    [self.headView setContentMode:UIViewContentModeScaleAspectFill];
    self.headIcon.image = [UIImage imageNamed:@"head0.png"];
    self.genderView = [[UIImageView alloc]initWithFrame:CGRectMake(self.headIcon.left-10,0,15,25)];
    [self.headView addSubview:_genderView];
    self.genderView.image = [UIImage imageNamed:@"man/womanGende.png"];
    self.genderView.top=_headIcon.top+_headIcon.height+5;
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.genderView.left+self.genderView.width+4, self.genderView.top,100, self.genderView.height)];
    self.nameLabel.textColor = [UIColor whiteColor];
    [self.headView addSubview:_nameLabel];
    self.nameLabel.text = @"Json Wam";
    [self.nameLabel setAutoresizingMask: UIViewAutoresizingFlexibleTopMargin];
    [self.headIcon setAutoresizingMask: UIViewAutoresizingFlexibleTopMargin];
    [self.genderView setAutoresizingMask: UIViewAutoresizingFlexibleTopMargin];

}



- (void)setBgContentOffsetAnimation:(CGFloat)OffsetY {
    [UIView animateWithDuration:.01 animations:^{
        self.tableView.contentOffset = CGPointMake(0, OffsetY);
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushedNewBtn
{
    //    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
    //    [sheet showInView:self.view.window];
    
    REDActionSheet *actionSheet = [[REDActionSheet alloc] initWithCancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitlesList:@"拍照", @"相册", nil];
	actionSheet.actionSheetTappedButtonAtIndexBlock = ^(REDActionSheet *actionSheet, NSUInteger buttonIndex) {
		//...
        if(buttonIndex== 2){
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
        
	};
	[actionSheet showInView:self.view];
    
    
}
#pragma mark- ImagePicker delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CLImageEditor *editor = [[CLImageEditor alloc] initWithImage:image];
    editor.delegate = self;
    
    [picker pushViewController:editor animated:YES];
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


#pragma mark -tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }else{
        return 35;
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, view.width, view.height)];
    label.text = @"签名: 走自己的时尚之路";
    [view addSubview:label];
    view.backgroundColor = RGBACOLOR(255, 255, 255, .5);
    return view;
    }else{
        if (!_menutabBar) {
            _menutabBar = [[ESMyMenuTabBar alloc]initWithFrame:CGRectMake(0, 0, 320, 35)];
            _menutabBar.delegate = self;
            
            [_menutabBar  initItemsTitles:@[
                                            @{@"Title":@"粉丝", @"EnglishTitle":@"(1)"},
                                            @{@"Title":@"关注", @"EnglishTitle":@""},
                                            @{@"Title":@"相册", @"EnglishTitle":@""},
                                            @{@"Title":@"收藏", @"EnglishTitle":@""},
                                            ]];
        }
        return _menutabBar;
    
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 195;
    }else{
        return 188;
    }
    return UITableViewAutomaticDimension;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }
    
    static NSString * showUserInfoCellIdentifier = @"ShowUserInfoCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil)
    {
        // Create a cell to display an ingredient.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:showUserInfoCellIdentifier]
                ;
    }
    
    // Configure the cell.
    cell.textLabel.text=@"签名";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //    BalancePlanManageInformation *model = [self.listArray objectAtIndex:indexPath.row];
    //    BalancePlanManageDetailViewController *detailVC = [[BalancePlanManageDetailViewController alloc] init];
    //    [detailVC setBalancePlanManageInfoModel:model];
    //    [self.navigationController pushViewController:detailVC animated:YES];
    //    [[BalancePlanTabBarViewController GetInstance] hideTabBarAnimated:YES];
    //    [detailVC release];
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


@end
