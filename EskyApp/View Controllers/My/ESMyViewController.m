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
@interface ESMyViewController ()<CLImageEditorDelegate, CLImageEditorThemeDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak,   nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImageView *headView;
@property (strong, nonatomic) UIImageView *headIcon;
@property (strong, nonatomic) UIImageView *genderView;
@property (strong, nonatomic) UILabel *nameLabel;
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
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, view.width, view.height)];
    label.text = @"签名: 走自己的时尚之路";
    [view addSubview:label];
    view.backgroundColor = RGBACOLOR(255, 255, 255, .5);
    return view;
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

@end
