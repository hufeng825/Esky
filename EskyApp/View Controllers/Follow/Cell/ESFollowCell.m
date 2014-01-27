//
//  ESFollowCell.m
//  EskyApp
//
//  Created by jason on 14-1-27.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESFollowCell.h"
#import "ESXibViewUtils.h"
#import "CSAnimation.h"

@implementation ESFollowCell
@synthesize shareBlock,loveBlock;

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
+ (ESFollowCell *)cellFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESFollowCell"];
}

- (IBAction)loveClicked:(id)sender {
    Class <CSAnimation> class = [CSAnimation classForAnimationType:CSAnimationTypeMorph];
    [class performAnimationOnView:sender duration:.45
                            delay:0];
    if (loveBlock) {
        loveBlock(nil);
    }
}

- (IBAction)shareClicker:(id)sender {
    if (shareBlock) {
        shareBlock(nil);
    }
}

@end
