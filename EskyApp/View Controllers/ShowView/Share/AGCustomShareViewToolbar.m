//
//  AGCustomShareViewToolbar.m
//  AGShareSDKDemo
//
//  Created by 冯 鸿杰 on 13-3-5.
//  Copyright (c) 2013年 vimfung. All rights reserved.
//

#import "AGCustomShareViewToolbar.h"
#import "AGCustomShareItemView.h"
#import <ShareSDK/ShareSDK.h>
#import "UIView+Additions.h"
#import <AGCommon/UIImage+Common.h>
#import <AGCommon/UIColor+Common.h>
#import "ESAppDelegate.h"

#import "ESCommonMacros.h"


#define ITEM_ID @"item"

@implementation AGCustomShareViewToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _appDelegate = (ESAppDelegate *)[UIApplication sharedApplication].delegate;
        
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = RGB(66, 66, 66);
        _textLabel.text = @"同时分享到:";
        _textLabel.font = [UIFont boldSystemFontOfSize:15];
        [_textLabel sizeToFit];
        _textLabel.frame = CGRectMake(3.0, 6.0, _textLabel.width + 2, self.height);
        _textLabel.contentMode = UIViewContentModeCenter;
        [self addSubview:_textLabel];
        
        _tableView = [[CMHTableView alloc] initWithFrame:CGRectMake(_textLabel.right, 0.0, self.width - _textLabel.right, self.height)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.itemWidth = 40;
        _tableView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_tableView];
        
        _oneKeyShareListArray = [[NSMutableArray alloc] initWithObjects:
                                 [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  SHARE_TYPE_NUMBER(ShareTypeQQSpace),
                                  @"type",
                                  [NSNumber numberWithBool:NO],
                                  @"selected",
                                  nil],
                                 [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                                  @"type",
                                  [NSNumber numberWithBool:NO],
                                  @"selected",
                                  nil],
                                 [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                                  @"type",
                                  [NSNumber numberWithBool:NO],
                                  @"selected",
                                  nil],
                                 [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                  @"type",
                                  [NSNumber numberWithBool:NO],
                                  @"selected",
                                  nil],
                                 [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                  @"type",
                                  [NSNumber numberWithBool:NO],
                                  @"selected",
                                  nil],
                                nil];
        
        
        
    }
    return self;
}

- (void)dealloc
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    _tableView = nil;
    
}



- (void)viewOnWillDisplay:(UIViewController *)viewController shareType:(ShareType)shareType
{
    
    [viewController.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    viewController.navigationItem.rightBarButtonItem = nil;
    
    UILabel *titleView = (UILabel *)viewController.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        viewController.navigationItem.titleView = titleView;
    }
    titleView.text = @"时尚先生认证";
    titleView.textColor = [UIColor blackColor];
    titleView.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0];
    [titleView sizeToFit];

}


- (NSArray *)selectedClients
{
    NSMutableArray *clients = [NSMutableArray array];
    
    for (int i = 0; i < [_oneKeyShareListArray count]; i++)
    {
        NSDictionary *item = [_oneKeyShareListArray objectAtIndex:i];
        if ([[item objectForKey:@"selected"] boolValue])
        {
            [clients addObject:item ];
        }
    }
    
    return clients;
}

#pragma mark - CMHTableViewDataSource

- (NSInteger)itemNumberOfTableView:(CMHTableView *)tableView
{
    return [_oneKeyShareListArray count];
}

- (UIView<ICMHTableViewItem> *)tableView:(CMHTableView *)tableView itemForIndexPath:(NSIndexPath *)indexPath
{
    AGCustomShareItemView *itemView = (AGCustomShareItemView *)[tableView dequeueReusableItemWithIdentifier:ITEM_ID];
    if (itemView == nil)
    {
        itemView = [[AGCustomShareItemView alloc] initWithReuseIdentifier:ITEM_ID
                                                              clickHandler:^(NSIndexPath *indexPath) {
                                                                  if (indexPath.row < [_oneKeyShareListArray count])
                                                                  {
                                                                      NSMutableDictionary *item = [_oneKeyShareListArray objectAtIndex:indexPath.row];
                                                                      ShareType shareType = [[item objectForKey:@"type"] integerValue];
                                                                      
                                                                      if ([ShareSDK hasAuthorizedWithType:shareType])
                                                                      {
                                                                         
                                                                          if (indexPath.row == 0 || indexPath.row == 1 ||indexPath.row == 2)
                                                                          {
                                                                              BOOL selected = ! [[item objectForKey:@"selected"] boolValue];

                                                                              for (int i =0 ; i<3 ; i++)
                                                                              {
                                                                                  NSMutableDictionary *_item = [_oneKeyShareListArray objectAtIndex:i];
                                                                                  [_item setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
                                                                               }
                                                                                 [item setObject:[NSNumber numberWithBool:selected] forKey:@"selected"];
                                                                            }
                                                                           else
                                                                            {
                                                                              BOOL selected = ! [[item objectForKey:@"selected"] boolValue];
                                                                              [item setObject:[NSNumber numberWithBool:selected] forKey:@"selected"];
                                                                            }
                                                                          [_tableView reloadData];
                                                                      }
                                                                      else
                                                                      {
                                                                          if (indexPath.row == 0 || indexPath.row == 1 ||indexPath.row == 2)
                                                                          {
                                                                              BOOL selected = ! [[item objectForKey:@"selected"] boolValue];
                                                                              
                                                                              for (int i =0 ; i<3 ; i++)
                                                                              {
                                                                                  NSMutableDictionary *_item = [_oneKeyShareListArray objectAtIndex:i];
                                                                                  [_item setObject:[NSNumber numberWithBool:NO] forKey:@"selected"];
                                                                              }
                                                                              [item setObject:[NSNumber numberWithBool:selected] forKey:@"selected"];
                                                                              [_tableView reloadData];
                                                                              //微信或者qq控件不支持一键分享 需要跳转客户端
                                                                              return ;
                                                                          }
                                                                          
                                                                          
                    
                                                                          
                                                                          id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                                                                                               allowCallback:YES
                                                                                                                               authViewStyle:SSAuthViewStyleModal
                                                                                                                                viewDelegate:self
                                                                                                                     authManagerViewDelegate:nil];
                                                                          
                                                                          //在授权页面中添加关注官方微博
                                                                          [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                          [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                                                                                          SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                                                                                          [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"ShareSDK"],
                                                                                                          SHARE_TYPE_NUMBER(ShareTypeTencentWeibo),
                                                                                                          nil]];
                                                                          
                                                                          [ShareSDK getUserInfoWithType:shareType
                                                                                            authOptions:authOptions
                                                                                                 result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                                                                                                     
                                                                                                     if (result)
                                                                                                     {
                                                                                                         [item setObject:[NSNumber numberWithBool:YES] forKey:@"selected"];
                                                                                                         [_tableView reloadData];
                                                                                                     }
                                                                                                     else
                                                                                                     {
                                                                                                         if ([error errorCode] != -103)
                                                                                                         {
                                                                                                             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"绑定失败!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                                                                                                             [alertView show];
                                                                                                         }
                                                                                                     }
                                                                                                 }];
                                                                      }
                                                                  }
                                                              }];
    }
    
    if (indexPath.row < [_oneKeyShareListArray count])
    {
        NSDictionary *item = [_oneKeyShareListArray objectAtIndex:indexPath.row];
        itemView.iconImageView.image = [self getClientIconWithType:item];

    }
    
    return itemView;
}


-(UIImage *)getClientIconWithType:(NSDictionary *)dict
{
    UIImage *image;
    NSInteger type = [[dict objectForKey:@"type"]integerValue];
    BOOL selected = [[dict objectForKey:@"selected"]boolValue];

    switch (type) {
        case ShareTypeTencentWeibo:
            if (selected) {
                image = [UIImage imageNamed:@"ShareTypeTencentWeibo"];
            }else{
                image = [UIImage imageNamed:@"ShareTypeTencentWeibo_disable"];
            }
            break;
        case ShareTypeSinaWeibo:
            if (selected) {
                image = [UIImage imageNamed:@"ShareTypeSinaWeibo"];
            }else{
                image = [UIImage imageNamed:@"ShareTypeSinaWeibo_disable"];
            }
            break;
        case ShareTypeWeixiTimeline:
            if (selected) {
                image = [UIImage imageNamed:@"ShareTypeWeixiTimeline"];
            }else{
                image = [UIImage imageNamed:@"ShareTypeWeixiTimeline_disable"];
            }
            break;
        case ShareTypeWeixiSession:
            if (selected) {
                image = [UIImage imageNamed:@"ShareTypeWeixiSession"];
            }else{
                image = [UIImage imageNamed:@"ShareTypeWeixiSession_disable"];
            }
            break;
        case ShareTypeQQSpace:
            if (selected) {
                image = [UIImage imageNamed:@"ShareTypeQQSpace"];
            }else{
                image = [UIImage imageNamed:@"ShareTypeQQSpace_disable"];
            }
            break;
            
        default:
            break;
    }
    return image;
}

@end
