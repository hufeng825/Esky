//
//  ESShowCommentNumber.m
//  EskyApp
//
//  Created by jason on 14-1-5.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESShowCommentNumber.h"
#import "ESXibViewUtils.h"

@implementation ESShowCommentNumber

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (ESShowCommentNumber *)viewFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESShowCommentNumber"];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
