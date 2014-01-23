//
//  ESSkillHomeViewController.m
//  EskyApp
//
//  Created by jason on 14-1-20.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESSkillHomeViewController.h"
#import "UIView+Additions.h"
#import "ESShowCell.h"

#import "ESSkillEditorSectionView.h"
#import "ESSkillExpertCommentCell.h"
#import "ESSkillShowEditorImageCell.h"


#import "ESInfoViewController.h"

@interface ESSkillHomeViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (weak, nonatomic) IBOutlet ESSkillMenuView *menuView;
@property (weak, nonatomic) IBOutlet UIButton *titleButton;

@end

@implementation ESSkillHomeViewController

-(id)initDrawerViewController:(YASlidingViewController *)dynamicsDrawerViewController
{
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {
        self.dynamicsDrawerViewController = dynamicsDrawerViewController;
    }
    return self;
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
    [self.menuView setDefaultButtonTag:10];
    [self toInitTableScrollView];
}

- (void)toInitTableScrollView
{
    [self.bgScrollView setContentSize:CGSizeMake(self.bgScrollView.frame.size.width*2,self.bgScrollView.frame.size.height )];
    [self.trendyitemsTable setFrame:CGRectMake(0, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height)];
    [self.subjectTable setFrame:CGRectMake(self.bgScrollView.frame.size.width, 0, self.bgScrollView.frame.size.width, self.bgScrollView.frame.size.height)];
    [self.bgScrollView addSubview:_trendyitemsTable];
    [self.bgScrollView addSubview:_subjectTable];
    [self.bgScrollView setPagingEnabled:YES];

}

- (IBAction)showMenuBtClick:(id)sender {
    if (_menuView.isShow) {
        [UIView animateWithDuration:kSkillAnimationDuration/2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_menuView hiddenSelf];
            _bgScrollView.top = _bgScrollView.top-_menuView.height;

        } completion:Nil];
    }else{
        [UIView animateWithDuration:kSkillAnimationDuration/2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [_menuView showSelf];
            _bgScrollView.top = _bgScrollView.top+_menuView.height;
            
        } completion:Nil];
    }
}

- (IBAction)titleBtClick:(id)sender {
    ((UIButton *)sender).selected = !((UIButton *)sender).selected;
    if (((UIButton *)sender).selected) {
        [_bgScrollView  setContentOffset:CGPointMake(self.bgScrollView.frame.size.width, 0) animated:YES];
    }else{
        [_bgScrollView  setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (IBAction)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
    [self.dynamicsDrawerViewController toggleLeftAnimated:YES];
}


#pragma mark - scrollView delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _bgScrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        _titleButton.selected = page%2;
    }
    
}

#pragma mark -tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 44;
    //    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = @[@"Jason",@"Candy",@"Trime",@"Hanme"];
    ESSkillEditorSectionView *view = [ESSkillEditorSectionView viewFromXib];
    view.headIconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"head%d.png",rand()%5]];
    view.nameLabel.text = array[rand()%4];
    if (section%2==0) {
        view.genderImageView.image = [UIImage imageNamed:@"man/manGende.png"];
    }else{
        view.genderImageView.image = [UIImage imageNamed:@"man/womanGende.png"];
    }
    return view;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
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
                return 195;
        }else{
            return 188;
        }
       return UITableViewAutomaticDimension;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *showEditorImageidentificer = @"ESShowEditorImageCell";
        ESSkillShowEditorImageCell *cell = [tableView dequeueReusableCellWithIdentifier:showEditorImageidentificer];
        if (!cell) {
            cell = [ESSkillShowEditorImageCell cellFromXib];
        }
        cell.testImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"dan%d.png",rand()%4]];
        return cell;
    }else{
    static NSString *expertCommentCellidentificer = @"ESSkillExpertCommentCell";
    ESSkillExpertCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:expertCommentCellidentificer];
    if (!cell) {
        cell = [ESSkillExpertCommentCell cellFromXib];
    }
    cell.starts.rating = rand()%5;
    [cell toSetTestImageView];
    return cell;
    }
    return nil;
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
