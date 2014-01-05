//
//  ESTalentPictureItem.m
//  EskyApp
//
//  Created by jason on 13-12-31.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESTalentPictureItem.h"
#import "FAThemeManager.h"



#define blurGgHight 35
#define headWith 30
#define spaceWith 5

@interface ESTalentPictureItem ()
@property (nonatomic ,strong) UIView  *blurBg;
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UIImageView *gendeView;
@property (nonatomic ,strong) UIImageView *talentHeadIcon;
@property (nonatomic ,strong) UITapGestureRecognizer *singleTap ;

@end

@implementation ESTalentPictureItem
@synthesize talentHeadIcon,nameLabel,gendeView,block,gende;

- (void)themeChanged
{
    [self setGende:self.gende];
}

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
    self.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
     _blurBg =  [[UIView alloc]initWithFrame:CGRectMake(0, self.height-blurGgHight, self.width,blurGgHight)];
    [_blurBg setBackgroundColor:[UIColor blackColor]];
    [_blurBg setAlpha:.6];
    [self addSubview:_blurBg];
    [self addSubview:self.talentHeadIcon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.gendeView];
    [self setGende:ManGende];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged) name:kThemeChangedNotification object:nil];
    [self setTalentName:@"Hason Jan"];
}

- (UIImageView *)talentHeadIcon
{
    if (!talentHeadIcon) {
        talentHeadIcon  = [[ESHeaderIconImageView alloc]initWithFrame:CGRectMake(15,self.height-blurGgHight/2-headWith/2, headWith, headWith)];
    }
    talentHeadIcon.image = [UIImage imageNamed:@"icon_head"];
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
        CGSize maximumLabelSize = CGSizeMake(75, blurGgHight);
        CGSize expectedSize = [self.nameLabel sizeThatFits:maximumLabelSize];
        [
          [self nameLabel] setWidth:
             (maximumLabelSize.width > expectedSize.width ? expectedSize.width :  maximumLabelSize.width)
         ];
        [self updateGendeViewCoord];
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


- (UILabel *) nameLabel
{
    if (!nameLabel) {
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(talentHeadIcon.frame.origin.x+talentHeadIcon.width+spaceWith,
                                self.blurBg.frame.origin.y,
                                80,
                                blurGgHight)];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [nameLabel setNumberOfLines:1];
        [nameLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return nameLabel;
}

- (UIImageView *) gendeView
{
    if (!gendeView) {
    gendeView = [[UIImageView alloc]initWithFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+spaceWith,self.height-blurGgHight/2-17/2, 12, 17)];
    };
    return gendeView;
}

- (void) updateGendeViewCoord
{
    [self.gendeView setFrame:CGRectMake(nameLabel.frame.origin.x+nameLabel.frame.size.width+spaceWith,self.height-blurGgHight/2-17/2,12,17)];
}

- (void) setGende:(Gende)gend
{
    if (gende == ManGende) {
        self.gendeView.image = [[FAThemeManager sharedManager] themeImageWithName:@"manGende.png"];
    }else{
        self.gendeView.image = [[FAThemeManager sharedManager] themeImageWithName:@"womanGende.png"];
    }
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
