//
//  FAModifyPassWordViewController.h
//  Esquire
//
//  Created by jason on 13-11-19.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FABaseViewController.h"

@interface FAModifyPassWordViewController : FABaseViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *cancleBt;
@property (weak, nonatomic) IBOutlet UIButton *okBt;
@property (weak, nonatomic) IBOutlet UIButton *successBt;
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UITextField *mmInput;

@end
