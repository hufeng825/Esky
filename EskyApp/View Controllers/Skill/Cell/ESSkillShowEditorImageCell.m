//
//  ESESShowEditorImageCell.m
//  EskyApp
//
//  Created by jason on 14-1-7.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESSkillShowEditorImageCell.h"

@implementation ESSkillShowEditorImageCell

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

+ (ESSkillShowEditorImageCell *)cellFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESSkillShowEditorImageCell"];
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
@end
