//
//  ESUserInfo.h
//  Esquire
//
//  Created by jason on 13-11-15.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESBaseModel.h"

@interface ESUserInfo : ESBaseModel{
    // 指定用户的性别
    NSString *_gender;
    
    // 用户绑定的手机号
    NSString *_bindedMobile;
    
    // 用户年龄
    NSString* _age;
    
    
    //邮箱
    NSString *_email;
    
    //密码
    
    
    // 表示用户的唯一ID。
    NSString* _userId;
    
    
    // 表示小的用户头像.50*50px
    NSString* _tinyurl;
    
    // 表示中等大小的用户头像.100*100px
    NSString* _headurl;
    
    // 表示高清大小的用户头像.200*200px
    NSString* _mainurl;
    
    // 表示用户的名字.
    NSString* _userName;
    
    // 是否在线
    BOOL _online;
    
    // 是否注册
    BOOL _isRegister;
    
    //电话
    NSString* _phoneNum;
    
}


@property (nonatomic, copy)NSString* gender;
@property (nonatomic, copy)NSString* bindedMobile;
@property (nonatomic, copy)NSString* age;
@property (nonatomic, copy)NSString* email;
@property (nonatomic, copy)NSString* userId;
@property (nonatomic, copy)NSString* tinyurl;
@property (nonatomic, copy)NSString* headurl;
@property (nonatomic, copy)NSString* mainurl;
@property (nonatomic, assign)BOOL online;
@property (nonatomic, assign)BOOL isRegister;
@property (nonatomic, copy)NSString* phoneNum;
@property (nonatomic, copy)NSString* userName;


- (id)initWithDictionary:(NSDictionary *)info;

@end
