//
//  HFTabBar.m
//  HFTabBarController
//
//  Created by jason on 13-12-17.
//  Copyright (c) 2013年 taobao. All rights reserved.
//

#import "HFTabBar.h"
#import "FAThemeManager.h"

#define kHFItemCount                    3
#define kHFItemTagBegin                 1000

@interface HFTabBar ()

@property (nonatomic, weak) UIView * customView;

@end


@implementation HFTabBar

@synthesize currentSelectIndex;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner
{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:xibName owner:fileOwner options:nil];
    if (array && [array count]) {
        return array[0];
    }else {
        return nil;
    }
}


- (void)commonInit
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged) name:kThemeChangedNotification object:nil];
    self.customView = [self loadViewFromXibNamed:NSStringFromClass([self class]) withFileOwner:self];
    _customView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_customView];
    currentSelectIndex = NSNotFound;
    [self addCallBack];
    [self themeChanged];
}

- (void)themeChanged
{
    [[self tarBarItem: (0 + kHFItemTagBegin)] setBackgroundImage:[[FAThemeManager sharedManager] themeImageWithName:@"home_active.png"] forState:UIControlStateSelected];
    [[self tarBarItem: (1 + kHFItemTagBegin)] setBackgroundImage:[[FAThemeManager sharedManager] themeImageWithName:@"skill_active.png"] forState:UIControlStateSelected];
    [[self tarBarItem: (2 + kHFItemTagBegin)] setBackgroundImage:[[FAThemeManager sharedManager] themeImageWithName:@"follow_active.png"] forState:UIControlStateSelected];
    [[self tarBarItem: (3 + kHFItemTagBegin)] setBackgroundImage:[[FAThemeManager sharedManager] themeImageWithName:@"show_active.png"] forState:UIControlStateSelected];
    [[self tarBarItem: (4 + kHFItemTagBegin)] setBackgroundImage:[[FAThemeManager sharedManager] themeImageWithName:@"mine_active.png"] forState:UIControlStateSelected];

}

- (void)addCallBack
{
    for (NSInteger i = 0 ; i < kHFItemCount; i ++) {
        __weak __typeof(self)weakSelf = self;
        [self addCallBack:^(NSUInteger tag,NSDictionary * userInfo)
        {
            [ [NSNotificationCenter defaultCenter]
                 postNotificationName:kHFTabBarNotificationFlag
                 object: [HFTabBarIndex initWithFromIndex:weakSelf.currentSelectIndex
                                                  toIndex:(tag-kHFItemTagBegin)]
                                                 userInfo:userInfo
             ];
            [weakSelf deselectSelectedItemWithOut:(tag-kHFItemTagBegin)];
            [weakSelf selectItemAtIndex:(tag-kHFItemTagBegin)];
        } index:i];
    }
}

- (void)addCallBack:(TabItemClickBlock)block index:(NSUInteger)index
{
    HFTabBarItem *item = [self tarBarItem: (kHFItemTagBegin+index)];
    item.block =block;
}


- (HFTabBarItem *)tarBarItem:(NSUInteger)index
{
    id view = [self.customView viewWithTag:index] ;
    if ([view isKindOfClass:[HFTabBarItem class] ]) {
        return (HFTabBarItem *)view;
    }else{
        NSAssert(NO, @"No index tag item");
        return nil;
    }
}

- (void)selectItemAtIndex:(NSUInteger)index
{
    self.currentSelectIndex = index ;
    [[self tarBarItem:(index+kHFItemTagBegin)] setIsActive:YES];
};


- (void)deselectSelectedItemWithOut:(NSUInteger)index
{
    for (NSInteger i = 0 ; i < kHFItemCount; i ++) {
        HFTabBarItem *item = [self tarBarItem: (i+kHFItemTagBegin)];
        if (item.tag != (index+kHFItemTagBegin)) {
            item.isActive = NO ;
        }
    }
};

@end


@implementation HFTabBarIndex

@synthesize fromIndex,toIndex;

- (id)init
{
    self = [super init];
    if (self) {
        fromIndex = NSNotFound;
        toIndex = NSNotFound;
    }
    return self;
}

+(HFTabBarIndex *)initWithFromIndex:(NSUInteger)fromindex toIndex:(NSUInteger)toindex
{
    HFTabBarIndex *returnValue = [[HFTabBarIndex alloc]init];
    returnValue.fromIndex = fromindex;
    returnValue.toIndex = toindex;
    return returnValue;
};



@end

