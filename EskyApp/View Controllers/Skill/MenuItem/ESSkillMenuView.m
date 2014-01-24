//
//  ESMyMenuView.m
//  EskyApp
//
//  Created by jason on 14-1-20.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESSkillMenuView.h"
#import "UIView+Additions.h"
#import "CSAnimation.h"


static NSInteger const buttonBegin = 10;
static NSInteger const buttonEnd = 15;


@implementation ESSkillMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addClickEvent];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addClickEvent];
    }
    self.isShow = NO;
    return self;
}

- (void)addClickEvent
{
    for (NSInteger i = buttonBegin; i <= buttonEnd ; i ++) {
        UIButton *bt = (UIButton *)[self viewWithTag:i];
        [bt addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)buttonClicked:(UIButton *)button
{
    
    for (NSInteger i = buttonBegin; i <= buttonEnd ; i ++) {
        UIButton *bt = (UIButton *)[self viewWithTag:i];
        [self unSelectButton:bt];
    }
    [self selectButton:button];
}


- (void)unSelectButton:(UIButton *)button
{
    button.selected = NO;
}

- (void)selectButton:(UIButton *)button
{
    button.selected = YES;
}


- (void)showSelf
{
    _isShow = YES;
    self.top = 65.f;
    Class <CSAnimation> class = [CSAnimation classForAnimationType:CSAnimationTypeBounceDown];
    [class performAnimationOnView:self duration:kSkillAnimationDuration delay:0];
//    self.transform = CGAffineTransformIdentity;
//    [UIView animateWithDuration:kSkillAnimationDuration animations:^{
//        self.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height);
//    } completion:^(BOOL finished) {
//        _isShow = YES;
//    }];
    
    
    
}

- (void)hiddenSelf
{
    [UIView animateWithDuration:kSkillAnimationDuration animations:^{
        self.top = 0.f;
    } completion:^(BOOL finished) {
        _isShow = NO;
    }];
}

- (void)setDefaultButtonTag:(NSInteger )tag
{
    UIButton *bt = (UIButton *)[self viewWithTag:tag];
    [self buttonClicked:bt];
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
