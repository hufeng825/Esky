//
//  ESPublishViewController.h
//  EskyApp
//
//  Created by jason on 14-1-10.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESBaseViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDK/ISSShareViewDelegate.h>


@interface ESPublishViewController : ESBaseViewController<UITextViewDelegate,ISSShareViewDelegate>

- (id)initWithImage:(UIImage *)image;

@end
