//
//  ESImageViewCell.h
//  EskyApp
//
//  Created by jason on 14-1-27.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESFollowImageViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *contextImage;

+ (ESFollowImageViewCell *)cellFromXib;

@end
