//
//  FAInputView.h
//  Esquire
//
//  Created by jason on 13-11-21.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FAInputView;

@protocol FATextFieldDelegate <NSObject>

@optional

- (BOOL)textFieldShouldBeginEditing:(FAInputView *)inputView;

- (void)textFieldDidBeginEditing:(FAInputView *)inputView;

- (void)textFieldDidEndEditing:(FAInputView *)inputView;

- (BOOL)textFieldShouldEndEditing:(FAInputView *)inputView;

- (BOOL)textField:(FAInputView *)input shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (BOOL)textFieldShouldClear:(FAInputView *)inputView;

- (BOOL)textFieldShouldReturn:(FAInputView *)inputView;

@end


@interface FAInputView : ESXibView<UITextFieldDelegate>

@property (nonatomic, weak) UIView * customView;

@property (nonatomic, copy) NSString * placeholderText;

@property (nonatomic, weak) UITextField * textField;

@property (nonatomic, weak) UIImageView * infoImageView;

@property (nonatomic, weak) UILabel * infoLabel;

@property (nonatomic, assign) BOOL state;

@property (nonatomic, weak) id<FATextFieldDelegate>delegate;

-(void)setData:(NSString *)infoTitle placeStr:(NSString *)placeStr delegate:(id)delgate;

-(void) becomeFirstResponder;

@end
