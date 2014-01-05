//
//  ESEditorSectionView.m
//  EskyApp
//
//  Created by jason on 14-1-5.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESEditorSectionView.h"
#import "ESXibViewUtils.h"

@implementation ESEditorSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (ESEditorSectionView *)viewFromXib
{
    return [ESXibViewUtils loadViewFromXibNamed:@"ESEditorSectionView"];
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
