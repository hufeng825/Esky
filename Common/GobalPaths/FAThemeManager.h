//
//  FAThemeManager.h
//  Esquire
//
//  Created by jason on 13-11-21.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kThemeChangedNotification  @"com.hufengvip.FAThemeManager.defaulttheme"


// Fired every time @property style is changed (except during init)
extern NSString * const RNThemeManagerDidChangeThemes;

@interface FAThemeManager : NSObject

// Singleton
+ (FAThemeManager*)sharedManager;

//主题名称
@property (nonatomic,strong) NSString *themeName;

//themes.plist文件中存储的字典数据，是主题名称与主题路径
@property (nonatomic,strong) NSDictionary *themesPlist;

//根据主题名称找到相应的主题路径，在各个主题路径对应的文件夹中存储的是主题字体颜色fontColor.plist
@property (nonatomic,strong) NSDictionary *themeColorPlist;


//获取主题图片
- (UIImage *)themeImageWithName:(NSString *)imageName;

//获取主题字体颜色,name为fontColor.plist文件中的key
- (UIColor *)themeColorWithName:(NSString *)name;

+ (void)changeBaseBackgourndColorWithImageName:(NSString *)imageName nv:(UIViewController *)nv;


@end
