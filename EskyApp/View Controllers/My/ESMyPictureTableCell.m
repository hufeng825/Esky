//
//  ESMyPictureTableCell.m
//  EskyApp
//
//  Created by jason on 14-1-24.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESMyPictureTableCell.h"

@implementation ESMyPictureTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (IBAction)removeClicked:(id)sender {
     [[self getTableView] beginUpdates];
    [[self getTableView] reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade ];//mock用了reload 实际中请替换成 deleteRowsAtIndexPaths
    [[self getTableView] endUpdates];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(UITableView *)getTableView
{
    //    id view = [self superview];
    //
    //    while ([view isKindOfClass:[UITableView class]] == NO) {
    //        view = [view superview];
    //        NSLog(@"%@",view);
    //    }
    
    UITableView *tableView = (UITableView *)self.superview.superview;
    return tableView;
}

+ (ESMyPictureTableCell *)cellFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESMyPictureTableCell"];
}


@end
