//
//  ESExpertCommentCell.m
//  EskyApp
//
//  Created by jason on 14-1-5.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESSkillExpertCommentCell.h"
#import "NSArray+Additions.h"

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

- (void) toSetTestImageView
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        [array addObject:[NSString stringWithFormat:@"skill%d.png",i] ];
    }
    [array  scramble];
    
    for (int i=0 ; i<5; i++ ) {
        ((UIImageView *)[_itemsImageView objectAtIndex:i]).image = [UIImage imageNamed: array[i] ];
    }
}



+ (ESSkillExpertCommentCell *)cellFromXib
{
    
    return [ESXibViewUtils loadViewFromXibNamed:@"ESSkillExpertCommentCell"];
}



@end
