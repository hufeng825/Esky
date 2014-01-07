//
//  ESShowTabBar.m
//  EskyApp
//
//  Created by jason on 13-12-26.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESMenuTabBar.h"
#import "ESMenuBarItem.h"


@interface ESMenuTabBar ()

@property (nonatomic, weak)    UIView * customView;
@property (nonatomic, strong)  UIView * activeBg;
@property (nonatomic, assign)  NSInteger itemCount;
@end

#define kMenuItemTagBegin 200


@implementation ESMenuTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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

- (void)addBg
{
    _itemCount = 0;
    for (id view in [_customView subviews]) {
        if ([view isKindOfClass:[ESMenuBarItem class] ]) {
            _itemCount ++ ;
            UIView *bgView = [[UIView alloc]initWithFrame:((UIView*)view).frame ];
            [bgView setBackgroundColor:[UIColor whiteColor]];
            [bgView setAlpha:.9];
            [self insertSubview:bgView belowSubview:_customView];
        }
    }
    [self insertSubview:self.activeBg belowSubview:_customView];
}

- (UIView *)activeBg
{
    if (!_activeBg) {
        self.activeBg = [[UIView alloc]initWithFrame:CGRectZero];
//      
        _activeBg.backgroundColor = RGBACOLOR(207, 23, 37,1);
    }
    return _activeBg;
}

- (void)commonInit
{
    self.customView = [self loadViewFromXibNamed:NSStringFromClass([self class]) withFileOwner:self];
    _customView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:_customView];
    [self addBg];
    [self addCallBack];
    [self selectMenuItemAtIndex:0];
}


- (void)addCallBack
{
    for (NSInteger i = 0 ; i < _itemCount; i ++) {
        __weak __typeof(self)weakSelf = self;
        [self addCallBack:^(NSInteger tag,BOOL isActive)
         {
             [weakSelf deselectSelectedItemWithOut:tag];
              CGRect rect =[weakSelf menuItem:tag-kMenuItemTagBegin ].frame;
             [UIView transitionWithView:weakSelf.activeBg duration:.2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                 [weakSelf.activeBg setFrame:rect];
             } completion:^(BOOL finished) {
                 if (finished) {
                 }
             }];
             if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(itemClicked:)])
             {
                 [weakSelf.delegate itemClicked:tag-kMenuItemTagBegin];
             }
         } index:i];
    }
}


- (void)addCallBack:(ItemClickBlock)block index:(NSInteger)index
{
    ESMenuBarItem *item = [self menuItem: index];
    item.block =block;
}

- (void)initItemsTitles:(NSArray *)array
{
    for (int i=0 ;i< [array count];i++) {
        @autoreleasepool {
            NSDictionary *dict = [array objectAtIndex:i];
            [ [self menuItem:i] setTextWithTitleStr:[dict stringForKey:@"Title"]  titleEnglistStr:[dict stringForKey:@"EnglishTitle"]];
        }
    }
}


- (ESMenuBarItem *)menuItem:(NSInteger)index
{
    int i = index+kMenuItemTagBegin;
    id view = [self.customView viewWithTag:i];
    if ([view isKindOfClass:[ESMenuBarItem class] ]) {
        return (ESMenuBarItem *)view;
    }else{
        NSAssert(NO, @"No index tag item ");
        return nil;
    }
}


- (void)selectMenuItemAtIndex:(NSInteger)index
{
    self.currentSelectIndex = index ;
    [[self menuItem:index] setIsActive:YES];
    [self deselectSelectedItemWithOut:(index+kMenuItemTagBegin)];
    CGRect rect =[self menuItem:index ].frame;
    [UIView transitionWithView:self.activeBg duration:.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.activeBg setFrame:rect];
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemClicked:)])
    {
        [self.delegate itemClicked:index];
    }
    
};


- (void)deselectSelectedItemWithOut:(NSInteger)tag
{
    for (NSInteger i = 0 ; i < _itemCount; i ++) {
        ESMenuBarItem *item = [self menuItem: i];
        if (item.tag != tag) {
            item.isActive = NO ;
        }
    }
};

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
