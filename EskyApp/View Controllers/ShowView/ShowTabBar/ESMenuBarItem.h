//
//  ESBarItem.h
//  EskyApp
//
//  Created by jason on 13-12-26.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^ItemClickBlock) (NSInteger tag,BOOL isActive);


@interface ESMenuBarItem : UIView


@property (nonatomic,copy) ItemClickBlock block;

@property (nonatomic,assign) BOOL isActive;

@property (nonatomic,assign) NSInteger *index;

-(void) setTextWithTitleStr:(NSString *)titleStr titleEnglistStr:(NSString *)titleEnglistStr;

@end
