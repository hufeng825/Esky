//
//  ESShowTabBar.h
//  EskyApp
//
//  Created by jason on 13-12-26.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  ESMyMenuTabBarDelegate;

@interface ESMyMenuTabBar : UIView
@property (nonatomic,assign) NSInteger currentSelectIndex;
@property (nonatomic,weak) id <ESMyMenuTabBarDelegate> delegate;

- (void)selectMenuItemAtIndex:(NSInteger)index;
- (void)initItemsTitles:(NSArray *)array;

@end


@protocol ESMyMenuTabBarDelegate <NSObject>

-(void)itemClicked:(NSInteger)index;


@end