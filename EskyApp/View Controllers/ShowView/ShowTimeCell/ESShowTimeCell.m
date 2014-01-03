//
//  ESShowCellCell.m
//  EskyApp
//
//  Created by jason on 14-1-3.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESShowTimeCell.h"
#import "ESXibViewUtils.h"


@implementation ESShowTimeCell

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

+ (ESShowTimeCell *)cellFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESShowTimeCell"];
}


@end
