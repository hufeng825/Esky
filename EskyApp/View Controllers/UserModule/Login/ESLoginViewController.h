//
//  ESLoginViewController.h
//  Esquire
//
//  Created by jason on 13-11-19.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAInputView.h"
#import "ESBaseViewController.h"

#import <ShareSDK/ShareSDK.h>

@interface ESLoginViewController :ESBaseViewController <ISSShareViewDelegate,ISSViewDelegate>

@property (weak, nonatomic) IBOutlet FAInputView *logoNameInput;
@property (weak, nonatomic) IBOutlet FAInputView *mmInput;

@property (weak, nonatomic) IBOutlet UIButton *loginBt;
@property (weak, nonatomic) IBOutlet UIButton *registerBt;
@property (weak, nonatomic) IBOutlet UIButton *resetMmBt;

- (IBAction)resetPassClick:(id)sender;
- (IBAction)regesitClick:(id)sender;
- (IBAction)qqloginClick:(id)sender;
- (IBAction)sinaLoginClick:(id)sender;

@end
