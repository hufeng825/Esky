//
//  ESExpertCommentCell.m
//  EskyApp
//
//  Created by jason on 14-1-5.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESSkillExpertCommentCell.h"

@implementation ESSkillExpertCommentCell
@synthesize starts;

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

- (ESRatingControl *)starts
{
    if (!starts ) {
        
//        starts = [[ESRatingControl alloc]initWithLocation:CGPointMake(202, 27) emptyColor:[UIColor yellowColor]
//                                               solidColor:[UIColor redColor]
//                                             andMaxRating:5];
    starts = [ [ESRatingControl alloc]initWithLocation:CGPointMake(202, 24) emptyImage:[UIImage imageNamed:@"man/starempty.png"] solidImage:[UIImage imageNamed:@"man/starsolid.png"] andMaxRating:5];
    }
    [self addSubview:starts];
    [starts setEnabled:NO];
    [self bringSubviewToFront:starts];
    return starts;
}

+ (ESSkillExpertCommentCell *)cellFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESSkillExpertCommentCell"];
}

@end
