//
//  ESTalentPictureItem.h
//  EskyApp
//
//  Created by jason on 13-12-31.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ESHeaderIconImageView.h"

typedef void (^TalentClickCallBack)();

typedef NS_ENUM(BOOL,Gende){
    ManGende  = YES,
    WOMANGende  = NO 
};


@interface ESTalentPictureItem : UIImageView

@property (nonatomic, copy) TalentClickCallBack block;
@property (nonatomic, assign) Gende gende;

- (void)setHeaderIcon:(NSString *)url;
- (void)setTalentName:(NSString *)name;
- (void)setGende:(Gende)gende;


@end
