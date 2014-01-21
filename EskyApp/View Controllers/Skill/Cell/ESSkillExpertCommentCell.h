//
//  ESExpertCommentCell.h
//  EskyApp
//
//  Created by jason on 14-1-5.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESRatingControl.h"



@interface ESSkillExpertCommentCell : UITableViewCell

@property (nonatomic, strong) ESRatingControl *starts;

+ (ESSkillExpertCommentCell *)cellFromXib;


@end
