//
//  ESInfoViewController.h
//  EskyApp
//
//  Created by jason on 14-1-4.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESBaseViewController.h"
#import "HFCycleScrollView.h"
#import <ShareSDK/ShareSDK.h>


@interface ESInfoViewController : ESBaseViewController<HFCycleScrollViewDatasource,HFCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@end
