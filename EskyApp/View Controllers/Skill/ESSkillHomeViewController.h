//
//  ESSkillHomeViewController.h
//  EskyApp
//
//  Created by jason on 14-1-20.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESBaseViewController.h"

#import "YASlidingViewController.h"
#import "ESBaseViewController.h"
#import "ESSkillMenuView.h"



@interface ESSkillHomeViewController : ESBaseViewController

@property (nonatomic, weak) YASlidingViewController *dynamicsDrawerViewController;

-(id)initDrawerViewController:(YASlidingViewController *)dynamicsDrawerViewController;

@property (strong, nonatomic) IBOutlet UITableView *trendyitemsTable;
@property (strong, nonatomic) IBOutlet UITableView *subjectTable;

@end
