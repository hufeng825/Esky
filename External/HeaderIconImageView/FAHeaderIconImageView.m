//
//  FAHeaderIconImageView.m
//  Esquire
//
//  Created by jason on 13-11-18.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "FAHeaderIconImageView.h"

@implementation FAHeaderIconImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder] )
    {
        [self commonInit];
    }
    return self;
}


-(void) commonInit
{
    // Initialization code
    self.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.layer.masksToBounds =YES;
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth =3.0f;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize =YES;
    self.clipsToBounds = YES;

    
//    self.layer.backgroundColor = (__bridge CGColorRef)([UIColor clearColor]);
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOffset = CGSizeMake(5,15);
//    self.layer.shadowOpacity = 0.5;
//    self.layer.shadowRadius = 2.0;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.width / 2].CGPath;
}

-(UITapGestureRecognizer *)singleTap
{
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:_singleTap];
        [self setMultipleTouchEnabled:YES];
        [self setUserInteractionEnabled:YES];
    }
    return _singleTap;
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
