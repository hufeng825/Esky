//
//  ESBaseViewController.h
//  Esquire
//
//  Created by jason on 13-10-23.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HFHttpRequestOperationManager.h"



@interface ESBaseViewController : UIViewController
//@property (nonatomic,strong)
@property (nonatomic, strong) HFHttpRequestOperationManager *hfClient;



-(void)postUrl:(NSString*)url
 postArguments:(NSDictionary *)parameters
ResponArgument:(HFHttpResponArguments *)responArguments;
-(void)gettUrl:(NSString*)url
ResponArgument:(HFHttpResponArguments *)responArguments;

-(void)themeChanged;

-(void)showWarning:(NSString *)warningStr;

-(void)showWarning:(NSString *)warningStr yOffset:(float)yOffset;

- (void)goBack;

@end
