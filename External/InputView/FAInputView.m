//
//  FAInputView.m
//  Esquire
//
//  Created by jason on 13-11-21.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "FAInputView.h"
#import "FAThemeManager.h"


@implementation FAInputView

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


-(void)commonInit
{
    self.customView = [FAInputView loadFromXib];
    [self addSubview:_customView];
    self.textField.delegate = self;
    
    [self.customView setHeight:self.height];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChanged:) name:kThemeChangedNotification object:nil];
    [self customTextColor];
    [self.infoImageView setAlpha:.4];
}


- (void)themeChanged:(NSNotification*)notification
{
    [self customTextColor];
}

- (void)customTextColor
{
    self.infoLabel.textColor = [[FAThemeManager sharedManager] themeColorWithName:@"kInputTitleColor"];
    self.textField.textColor = [[FAThemeManager sharedManager] themeColorWithName:@"kInputNormalColor"];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) setFontSize:(CGFloat)fontSize
{
    [self.textField setFont:[UIFont systemFontOfSize:fontSize]];
}

-(UILabel *) infoLabel
{
    return (UILabel *)[self.customView viewWithTag:100];
}

-(UITextField *) textField
{
    return  (UITextField *)[self.customView viewWithTag:101];
}

-(UIImageView *)infoImageView
{
    return (UIImageView *) [self.customView viewWithTag:102];
}

-(NSString *)text
{
    return  [self textField].text;
}

-(void) setSecureTextEntry:(BOOL) secureTextEntry
{
    [self.textField setSecureTextEntry:secureTextEntry];
}

-(void)setPlaceholderText:(NSString *)placeholderText
{
    self.textField.placeholder = placeholderText;
    self.textField.textColor = [[FAThemeManager sharedManager] themeColorWithName:@"kInputNormalColor"];
}

-(void) setActiveColor
{
    self.textField.textColor = [[FAThemeManager sharedManager] themeColorWithName:@"kInputActiveColor"];
}

-(void) setNormeColor
{
    self.textField.textColor = [[FAThemeManager sharedManager] themeColorWithName:@"kInputNormalColor"];
}

-(void) becomeFirstRespond
{
    [self.textField becomeFirstResponder];
}
#pragma mark UITextFiledDelegate

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    [self.customView setBackgroundColor: RGBACOLOR(255,255,255,.9)];
    [self.infoImageView setAlpha:.4];
    [self setActiveColor];
    [self.infoImageView setImage:[UIImage imageNamed:@"check_true.png"]];
    [UIView commitAnimations];
    });
    
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        [self.delegate textFieldShouldBeginEditing:self];
    }
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
  
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:self];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    if (!TTIsStringWithAnyText(textField.text)) {
        [self.infoImageView setAlpha:.4];
    }
    [self.customView setBackgroundColor: RGBACOLOR(255,255,255,1)];
    [self setNormeColor];
    [UIView commitAnimations];
    });
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
    [self.delegate textFieldDidEndEditing:self];
    }
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {

    [self.delegate textFieldShouldEndEditing:self];
    }
    return YES;
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_delegate && [_delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
    [self.delegate textField:self shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
    [self.delegate textFieldShouldClear:self];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_delegate && [_delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
    [self.delegate textFieldShouldReturn:self];
    }
    return YES;
}

-(void)setIsError:(BOOL)isError
{

//    if (_state !=state)
    {
        _isError = isError;
//        state == NO ? [self.infoImageView setImage:[UIImage imageNamed:@"check_true.png"]] : [self.infoImageView setImage:[UIImage imageNamed:@"check_wrong.png"]];
        dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.infoImageView cache:YES];
        if (_isError == YES)
        {
            [self.infoImageView setImage:[UIImage imageNamed:@"check_wrong.png"]];
        }
        else
        {
            [self.infoImageView setImage:[UIImage imageNamed:@"check_true.png"]];
        }
            [UIView commitAnimations];});
    }
    [self.infoImageView setAlpha:1];
}


-(void)setData:(NSString *)infoTitle placeStr:(NSString *)placeStr delegate:(id)delgate
{
    if (TTIsStringWithAnyText(infoTitle)) {
        self.infoLabel.hidden = NO;
        [self.textField setFrame:CGRectMake(90, 0, 185,self.height)];
    }
    else{
        self.infoLabel.hidden= YES;
        [self.textField setFrame:CGRectMake(44,0,185,self.height)];
    }
    
    [self.infoImageView setAlpha:.4];
    self.infoLabel.text = infoTitle;
    self.placeholderText = placeStr;
    self.delegate = delgate;
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
