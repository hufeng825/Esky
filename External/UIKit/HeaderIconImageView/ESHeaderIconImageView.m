//
//  FAHeaderIconImageView.m
//  Esquire
//
//  Created by jason on 13-11-18.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESHeaderIconImageView.h"

@implementation ESHeaderIconImageView

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

   self.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.layer.masksToBounds =YES;
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    if (self.width >30) {
        self.layer.borderWidth = 3.0f;
    }else{
        self.layer.borderWidth = .8f;
    }
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.shouldRasterize =YES;
    self.clipsToBounds = YES;
    self.image = [UIImage imageNamed:@"icon_head.png"];
    
    
//    self.layer.backgroundColor = (__bridge CGColorRef)([UIColor clearColor]);
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOffset = CGSizeMake(5,15);
//    self.layer.shadowOpacity = 0.5;
//    self.layer.shadowRadius = 2.0;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.frame.size.width / 2].CGPath;
}

//-(void)drawRect:(CGRect)rect
//{
//    
//    CGFloat radius = 0.5*rect.size.width;
//    
//    CGContextRef ref = UIGraphicsGetCurrentContext();
//    
//    /* We can only draw inside our view, so we need to inset the actual 'rounded content' */
//    CGRect contentRect = CGRectInset(rect, radius, radius);
//    
//    /* Create the rounded path and fill it */
//    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:contentRect cornerRadius:.6];
//    CGContextSetFillColorWithColor(ref,[UIColor blackColor].CGColor);
//    CGContextSetShadowWithColor(ref, CGSizeMake(0.0, 0.0), radius, [UIColor blackColor].CGColor);
//    [roundedPath fill];
//    
//    /* Draw a subtle white line at the top of the view */
//    [roundedPath addClip];
//    CGContextSetStrokeColorWithColor(ref, [UIColor colorWithWhite:1.0 alpha:0.6].CGColor);
//    CGContextSetBlendMode(ref, kCGBlendModeOverlay);
//    
//    CGContextMoveToPoint(ref, CGRectGetMinX(contentRect), CGRectGetMinY(contentRect)+0.5);
//    CGContextAddLineToPoint(ref, CGRectGetMaxX(contentRect), CGRectGetMinY(contentRect)+0.5);
//    CGContextStrokePath(ref);
//}

- (UIImage *)imageByDrawingCircleOnImage:(UIImage *)image
{
    UIImage *finalImage = nil;
	UIGraphicsBeginImageContext(image.size);
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGAffineTransform trnsfrm = CGAffineTransformConcat(CGAffineTransformIdentity, CGAffineTransformMakeScale(1.0, -1.0));
        trnsfrm = CGAffineTransformConcat(trnsfrm, CGAffineTransformMakeTranslation(0.0, image.size.height));
        CGContextConcatCTM(ctx, trnsfrm);
        CGContextBeginPath(ctx);
        CGContextAddEllipseInRect(ctx, CGRectMake(0.0, 0.0, image.size.width, image.size.height));
        CGContextClip(ctx);
        CGContextDrawImage(ctx, CGRectMake(0.0, 0.0, image.size.width, image.size.height), image.CGImage);
        finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return finalImage;
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


@end
