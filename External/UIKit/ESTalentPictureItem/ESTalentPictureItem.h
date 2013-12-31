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

@interface ESTalentPictureItem : UIImageView

@property(nonatomic,copy) TalentClickCallBack block;

- (void)setHeaderIcon:(NSString *)url;
- (void)setTalentName:(NSString *)name;


@end
