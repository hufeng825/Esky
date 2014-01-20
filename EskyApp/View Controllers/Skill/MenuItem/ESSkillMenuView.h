//
//  ESSkillMenuView.h
//  EskyApp
//
//  Created by jason on 14-1-20.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat   const kSkillAnimationDuration = 0.5;


@interface ESSkillMenuView : UIView

@property (nonatomic,assign) BOOL isShow;

- (void)setDefaultButtonTag:(NSInteger )tag;

- (void)showSelf;

- (void)hiddenSelf;

@end
