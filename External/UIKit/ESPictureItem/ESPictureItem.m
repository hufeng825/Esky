//
//  ESPictureItem.m
//  EskyApp
//
//  Created by jason on 13-12-30.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESPictureItem.h"


@interface ESPictureItem ()
@property (nonatomic, weak) UIView * customView;
@property (nonatomic, weak) UIView * typeBg;
@property (nonatomic, weak) UILabel * typeLabel;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel * pageView;
@end

@implementation ESPictureItem


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


- (void)commonInit
{
    self.customView = [self loadViewFromXibNamed:NSStringFromClass([self class]) withFileOwner:self];
    _customView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:_customView];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (void) setStyle:(PictureStyle)style
{
    switch (style) {
        case ProfessorPictureStyle:
            [self showStyle:YES];
            [[self typeLabel] setText:@"专家点评" ];
            break;
        case ActivePictureStyle:
            [self showStyle:YES];
            [[self typeLabel] setText:@"活动" ];
            break;
        case NormalPictureStyle:
            [self showStyle:NO];
            break;

        default:
            break;
    }
}


- (void) setPageviewCount:(NSString *)str
{
    [[self pageViewLabel] setText:str ];
}

- (UIImageView *)imageView
{
    return (UIImageView *)[self.customView viewWithTag:100];
}

- (UIView *)typeBg
{
    return [self.customView viewWithTag:101];
}

- (UILabel *)typeLabel
{
    return (UILabel *)[self.customView viewWithTag:102];
}

- (UILabel *)pageViewLabel
{
    return (UILabel *)[self.customView viewWithTag:103];
}

- (void) showStyle:(BOOL)isYes
{
    [[self typeBg] setHidden:!isYes];
    [[self typeLabel]setHidden:!isYes];
}


@end
