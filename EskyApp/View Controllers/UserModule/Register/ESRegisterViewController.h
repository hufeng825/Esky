//
//  ESRegisterViewController.h
//  Esquire
//
//  Created by jason on 13-11-18.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESBaseViewController.h"
#import "FAHeaderIconImageView.h"

#import "FAInputView.h"



@interface ESRegisterViewController : ESBaseViewController<UITextFieldDelegate,
                                                            UIImagePickerControllerDelegate,
                                                            UIGestureRecognizerDelegate,
                                                            UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet FAHeaderIconImageView *headIconImageView;
@property (weak, nonatomic) IBOutlet UIButton *registButton;
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;


@property (weak, nonatomic) IBOutlet FAInputView *emailInput;
@property (weak, nonatomic) IBOutlet FAInputView *mmInput;
@property (weak, nonatomic) IBOutlet FAInputView *verifyInput;
@property (weak, nonatomic) IBOutlet FAInputView *nickNameInput;



@end
