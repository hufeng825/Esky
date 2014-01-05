//
//  ESShowSendCommentCell.m
//  EskyApp
//
//  Created by jason on 14-1-5.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESShowSendCommentCell.h"
#import "ESXibViewUtils.h"

@implementation ESShowSendCommentCell

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

+ (ESShowSendCommentCell *)cellFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESShowSendCommentCell"];
}

@end
