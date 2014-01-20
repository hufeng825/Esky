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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
//    if (tableView == _trendyitemsTable ) {
//        static NSString *showidentificer = @"ESShowCell";
//        ESShowCell *cell = [tableView dequeueReusableCellWithIdentifier:showidentificer];
//        if (cell == nil) {
//            cell = [ESShowCell cellFromXib];
//        }
//        return cell;
//    }else if (tableView == _subjectTable ){
//        static NSString *showidentificer = @"ESShowCell";
//        ESShowCell *cell = [tableView dequeueReusableCellWithIdentifier:showidentificer];
//        if (cell == nil) {
//            cell = [ESShowCell cellFromXib];
//        }
//        return cell;
//    }
    return Nil;
    
}


@end
