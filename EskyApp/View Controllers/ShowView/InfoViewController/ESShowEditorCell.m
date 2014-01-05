//
//  ESShowEditorCell.m
//  EskyApp
//
//  Created by jason on 14-1-4.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESShowEditorCell.h"
#import "ESXibViewUtils.h"


@implementation ESShowEditorCell

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


+ (ESShowEditorCell *)cellFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESShowEditorCell"];
}


@end
