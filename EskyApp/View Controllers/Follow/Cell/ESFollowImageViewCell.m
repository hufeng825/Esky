//
//  ESImageViewCell.m
//  EskyApp
//
//  Created by jason on 14-1-27.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESFollowImageViewCell.h"

@implementation ESFollowImageViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (ESFollowImageViewCell *)cellFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESFollowImageViewCell"];
}

@end
