//
//  HFTabBarItem.h
//  HFTabBarController
//
//  Created by jason on 13-12-17.
//  Copyright (c) 2013年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>


typedef  void (^TabItemClickBlock) (NSUInteger tag,id userInfo);

@interface HFTabBarItem : UIButton

@property (nonatomic,strong) NSDictionary *userInfo;

@property (nonatomic,copy) TabItemClickBlock block;

@property (nonatomic,assign) BOOL isActive;

@end
