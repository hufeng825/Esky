//
//  ESCommentCell.m
//  EskyApp
//
//  Created by jason on 14-1-3.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESCommentCell.h"
#import "ESXibViewUtils.h"

@interface  ESCommentCell()
@end

@implementation ESCommentCell
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
//        starts = [[ESRatingControl alloc]initWithLocation:CGPointMake(188, 69) emptyColor:[UIColor yellowColor]
//                                               solidColor:[UIColor redColor]
//                                             andMaxRating:5];
        starts = [ [ESRatingControl alloc]initWithLocation:CGPointMake(195, 70) emptyImage:[UIImage imageNamed:@"man/starempty.png"] solidImage:[UIImage imageNamed:@"man/starsolid.png"] andMaxRating:5];
    }
    [self addSubview:starts];
    [starts setEnabled:NO];
    [self bringSubviewToFront:starts];
    return starts;
}


+ (ESCommentCell *)cellFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESCommentCell"];
}


@end
