//
//  ESShowEditorCell.m
//  EskyApp
//
//  Created by jason on 14-1-4.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESShowEditorCell.h"
#import "ESXibViewUtils.h"
#import "CSAnimation.h"


@implementation ESShowEditorCell
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

- (IBAction)resetHeight:(id)sender {
    HFAlert(@"稍后完成");
//    id view = [self superview];
//    
//    while ([view isKindOfClass:[UITableView class]] == NO) {
//        view = [view superview];
//    }
//    
//    UITableView *tableView = (UITableView *)view;
//    [tableView beginUpdates];
//    [tableView endUpdates];
}

+ (ESShowEditorCell *)cellFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESShowEditorCell"];
}


@end
