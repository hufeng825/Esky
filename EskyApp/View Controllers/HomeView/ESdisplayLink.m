//
//  ESdisplayLink.m
//  EskyApp
//
//  Created by jason on 13-12-26.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESdisplayLink.h"

@interface ESdisplayLink()
@property (nonatomic,weak) iCarousel *icarousel;
@end

@implementation ESdisplayLink
@synthesize icarousel;

-(id)initWithTarget:(id)target  iCarousel:(iCarousel *)carousel
{
    self = (ESdisplayLink *)[CADisplayLink displayLinkWithTarget:target selector:@selector(step)];
    if (self) {
        self.icarousel = carousel;
        self.frameInterval = 1;
        [self addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void)step
{
    if (icarousel.scrolling) {
        return;
    }else{
        [icarousel scrollByNumberOfItems:icarousel.numberOfItems duration:1];
    }
}

@end
