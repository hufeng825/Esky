//
//  ESBaseViewController.h
//  Esquire
//
//  Created by jason on 13-10-23.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFHttpRequestManager.h"
#import "ESRequest.h"


@interface ESBaseViewController : UIViewController

-(void)themeChanged;

-(void)showWarning:(NSString *)warningStr;

-(void)showWarning:(NSString *)warningStr yOffset:(float)yOffset;

- (void)goBack;

@end
