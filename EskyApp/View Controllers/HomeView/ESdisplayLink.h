//
//  ESdisplayLink.h
//  EskyApp
//
//  Created by jason on 13-12-26.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "iCarousel.h"

@interface ESdisplayLink : CADisplayLink

-(id)initWithTarget:(id)target  iCarousel:(iCarousel *)iCarousel;

@end
