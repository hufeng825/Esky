//
//  ESUserModel.h
//  EskyApp
//
//  Created by jason on 13-12-9.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESBaseModel.h"

@interface ESUserModel : ESBaseModel

@property (nonatomic, copy)NSString* email;
@property (nonatomic, copy)NSString* userId;
@property (nonatomic, copy)NSString* headUrl;
@property (nonatomic, copy)NSString* userName;
@property (nonatomic, copy)NSString* nickName;


@end
