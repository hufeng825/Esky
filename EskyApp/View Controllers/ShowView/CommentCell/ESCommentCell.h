//
//  ESCommentCell.h
//  EskyApp
//
//  Created by jason on 14-1-3.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESHeaderIconImageView.h"
#import "ESRatingControl.h"

@interface ESCommentCell : UITableViewCell


@property (nonatomic, strong) ESRatingControl *starts;

+ (ESCommentCell *)cellFromXib ;

- (ESRatingControl *)starts;

@end
