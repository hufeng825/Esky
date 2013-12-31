//
//  ESTalentPictureItem.m
//  EskyApp
//
//  Created by jason on 13-12-31.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESTalentPictureItem.h"

#define blurGgHight 35
#define headWith 30
#define spaceWith 10

@interface ESTalentPictureItem ()
@property (nonatomic ,strong) UIView  *blurBg;
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) ESHeaderIconImageView *talentHeadIcon;
@property (nonatomic ,strong) UITapGestureRecognizer *singleTap ;

@end

@implementation ESTalentPictureItem
@synthesize talentHeadIcon,nameLabel,block;


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

- (void)commonInit
{
     _blurBg =  [[UIView alloc]initWithFrame:CGRectMake(0, self.height-blurGgHight, self.width,blurGgHight)];
    [_blurBg setBackgroundColor:[UIColor blackColor]];
    [_blurBg setAlpha:.8];
    self.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:_blurBg];
    [self addSubview:self.talentHeadIcon];
    [self addSubview:self.nameLabel];
    
    [self setTalentName:@"文字超出限制显示省略号"];
}

- (ESHeaderIconImageView *)talentHeadIcon
{
    if (!talentHeadIcon) {
        talentHeadIcon  = [[ESHeaderIconImageView alloc]initWithFrame:CGRectMake(15,self.height-blurGgHight/2-headWith/2, headWith, headWith)];
    }
    return talentHeadIcon;
}

- (void)setHeaderIcon:(NSString *)url
{
    [self.talentHeadIcon setImageWithURL:[NSURL URLWithString:url]];
}

- (void)setTalentName:(NSString *)name
{
    if (TTIsStringWithAnyText(name)) {
        [self nameLabel].text = name;
        CGSize maximumLabelSize = CGSizeMake(90, blurGgHight);
        CGSize expectedSize = [self.nameLabel sizeThatFits:maximumLabelSize];
        [
          [self nameLabel] setWidth:
             (maximumLabelSize.width > expectedSize.width ? expectedSize.width :  maximumLabelSize.width)
         ];
    }
}

-(UITapGestureRecognizer *)singleTap
{
    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] init];
        [self addGestureRecognizer:_singleTap];
        [self setMultipleTouchEnabled:YES];
        [self setUserInteractionEnabled:YES];
    }
    return _singleTap;
}


-(void)setBlock:(TalentClickCallBack)newblock
{
    if(block != newblock)
    {
        block = [newblock copy];
    };
    [self.singleTap addTarget:self action:@selector(clicked)];
    [self removeGestureRecognizer:self.singleTap];
    [self addGestureRecognizer:self.singleTap];
}

-(void)clicked
{
    block();
}


- (UILabel *)nameLabel
{
    if (!nameLabel) {
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(talentHeadIcon.frame.origin.x+talentHeadIcon.width+spaceWith,
                                                             self.blurBg.frame.origin.y,
                                                             100,
                                                             blurGgHight)];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setNumberOfLines:1];
        [nameLabel setBackgroundColor:[UIColor redColor] ];
        [nameLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return nameLabel;
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
