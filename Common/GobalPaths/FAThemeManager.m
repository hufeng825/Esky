//
//  FAThemeManager.m
//  Esquire
//
//  Created by jason on 13-11-21.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "FAThemeManager.h"

@interface FAThemeManager ()

@property(nonatomic, strong, readwrite) NSDictionary *styles;
@property(nonatomic, strong, readwrite) NSString *currentThemeName;

@end

@implementation FAThemeManager


+ (FAThemeManager *)sharedManager {
    static FAThemeManager *_sharedTheme = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTheme = [[self alloc] init];
    });

    return _sharedTheme;
}


- (id)init {

    if (self = [super init]) {
        NSString *themesPlistPath = [[NSBundle mainBundle] pathForResource:@"themes" ofType:@"plist"];
        self.themesPlist = [NSDictionary dictionaryWithContentsOfFile:themesPlistPath];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *themeName = [defaults objectForKey:kThemeChangedNotification];
        self.themeColorPlist = nil;
        self.themeName = themeName;
    }
    return self;
}


//重写setThemeName方法
- (void)setThemeName:(NSString *)themeName {
    if (_themeName != themeName) {
        _themeName = themeName;

        //主题路径
        NSString *themePath = [self _themePathWithThemeName];
        self.themeColorPlist = [NSDictionary dictionaryWithContentsOfFile:[themePath stringByAppendingPathComponent:@"fontColor.plist"]];

        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeChangedNotification object:self];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:themeName forKey:kThemeChangedNotification];
        [defaults synchronize];
    }
}

#pragma mark -
//根据主题名称获取相应的主题路径
- (NSString *)_themePathWithThemeName {
    NSString *themePath = nil;
    //默认情况self.themeName为空
    if (self.themeName == nil) {
        themePath = [[NSBundle mainBundle] resourcePath];
    } else {
        //根据themeName在themes.plist文件中获取相应的主题路径
        themePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.themesPlist[self.themeName]];
    }
    return themePath;
}

//获取主题图片
- (UIImage *)themeImageWithName:(NSString *)imageName {
    //判断imageName是否为nil，或者是否具有有效数据
    if (imageName == nil || [[imageName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        return nil;
    }

    //主题路径
    NSString *themePath = [self _themePathWithThemeName];
    //图片路径
    NSString *imagePath = [themePath stringByAppendingPathComponent:imageName];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];

    return image;
}


//获取主题字体颜色,name为fontColor.plist文件中的key
- (UIColor *)themeColorWithName:(NSString *)name {
    //判断name是否为nil，或者是否具有有效数据
    if (name == nil || [[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
        return nil;
    }

    NSString *colorStr = self.themeColorPlist[name];
    NSArray *colors = [colorStr componentsSeparatedByString:@","];
    if (colors.count == 3) {
        UIColor *color = [UIColor colorWithRed:[colors[0] floatValue] / 255.0f green:[colors[1] floatValue] / 255.0f blue:[colors[2] floatValue] / 255.0f alpha:1.0f];
        return color;
    }

    return nil;
}

+ (void)changeBaseBackgourndColorWithImageName:(NSString *)imageName nv:(UIViewController *)nv {
    UIColor *bgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageName]];
    if ([nv.view isKindOfClass:[UITableView class]]) {
        UIView *viewi = [[UIView alloc] initWithFrame:nv.view.bounds];
        viewi.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        viewi.backgroundColor = bgColor;
        UITableView *tView = (UITableView *) nv.view;
        if ([tView respondsToSelector:@selector(setBackgroundView:)]) {
            [tView setBackgroundView:viewi];
        }
    }
    nv.view.backgroundColor = bgColor;
}

@end
