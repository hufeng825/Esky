//
//  ESBarItem.m
//  EskyApp
//
//  Created by jason on 13-12-26.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESMyMenuBarItem.h"



@interface  ESMyMenuBarItem()

@property (nonatomic, weak) UIView * customView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end


@implementation ESMyMenuBarItem

@synthesize block;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    self.customView = [self loadViewFromXibNamed:NSStringFromClass([self class]) withFileOwner:self];
    _customView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_customView];
    [self setBackgroundColor:[UIColor clearColor]];
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTouchUpInside)];
    //单点触摸
    self.tap.numberOfTouchesRequired = 1;
    self.tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:self.tap];
}

- (void)doTouchUpInside {
    
     self.isActive = YES;

    if (block)
    {
        block(self.tag,self.isActive);
    }
    
}

- (void)setIsActive:(BOOL)isActive
{
    NSLog(@"%d",self.tag);
    if (_isActive != isActive) {
        _isActive = isActive ;
        if (isActive) {
            [self changeTextColor:[UIColor whiteColor]];
        }else{
            [self changeTextColor:RGBCOLOR(133, 133, 133)];
        }
    }
}

- (UILabel *)titleLable
{
    return (UILabel *)[self.customView viewWithTag:100];
}

- (UILabel *)titleEnglishLable
{
    return (UILabel *)[self.customView viewWithTag:101];
}

-(void) changeTextColor:(UIColor *)color
{
    [[self titleLable] setTextColor:color];
    [[self titleEnglishLable] setTextColor:color];
}

-(void) setTextWithTitleStr:(NSString *)titleStr titleEnglistStr:(NSString *)titleEnglistStr
{
    [[self titleLable] setText:titleStr];
    [[self titleEnglishLable] setText:titleEnglistStr];
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
