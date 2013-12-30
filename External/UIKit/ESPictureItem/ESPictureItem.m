//
//  ESPictureItem.m
//  EskyApp
//
//  Created by jason on 13-12-30.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESPictureItem.h"


@interface ESPictureItem ()

@property (nonatomic, weak) UIView * customView;

@end

@implementation ESPictureItem


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:xibName owner:fileOwner options:nil];
    if (array && [array count]) {
        return array[0];
    }else {
        return nil;
    }
}


- (void)commonInit
{
    self.customView = [self loadViewFromXibNamed:NSStringFromClass([self class]) withFileOwner:self];
    _customView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_customView];
    [self setBackgroundColor:[UIColor clearColor]];
}




@end
