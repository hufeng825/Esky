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


@interface ESInfoViewController ()

@property (strong, nonatomic) IBOutlet UITableView *infoCurrentTable;
@property (weak,   nonatomic) IBOutlet HFCycleScrollView *cycleView;

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }else if(section ==1){
        return 30;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        if (indexPath.row == 0) {
            return 336;
        }else
            return 200;
    }else if(indexPath.section == 1){
        if (indexPath != 0) {
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
        return view;
    }
    return Nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
//    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            ESShowEditorCell *cell = [ESShowEditorCell cellFromXib];
            cell.testImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",rand()%19]];
            return cell;
        }else if(indexPath.row == 1){
            ESExpertCommentCell *cell = [ESExpertCommentCell cellFromXib];
            cell.starts.rating = rand()%5;
            return cell;
        }

    }
    else if(indexPath.section == 1)
    {
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
