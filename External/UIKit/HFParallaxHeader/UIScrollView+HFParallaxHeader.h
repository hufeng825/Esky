//
//  UIScrollView+HFParallaxHeader.h
//
//  Created by jason on 2013-04-12.
//  Copyright (c) 2013 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HFParallaxView;
@class HFParallaxShadowView;

@interface UIScrollView (HFParallaxHeader)

- (void)addParallaxWithImage:(UIImage *)image andHeight:(CGFloat)height;
- (void)addParallaxWithView:(UIView*)view andHeight:(CGFloat)height;

@property (nonatomic, strong, readonly) HFParallaxView *parallaxView;
@property (nonatomic, assign) BOOL showsParallax;

@end

enum {
    HFParallaxTrackingActive = 0,
    HFParallaxTrackingInactive
};

typedef NSUInteger HFParallaxTrackingState;

@interface HFParallaxView : UIView

@property (nonatomic, readonly) HFParallaxTrackingState state;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *currentSubView;
@property (nonatomic, strong) HFParallaxShadowView *shadowView;

@end

@interface HFParallaxShadowView : UIView

@end
