//
//  FAMainUser.m
//  Esquire
//
//  Created by jason on 13-11-15.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "FAMainUser.h"

// mainUser持久化文件名
#define kMainUserFileName @"user"
// 公共目录名
#define kCommonDir @"common"
// 广告存储目录
#define kSplashDir @"splash"
// 广告信息存储名字
#define kSplashName @"splashInfo"
// 广告内容存储名字
#define kSplashData @"splashData"
// 最后一次用户登陆ID
#define kLastLoginUserId    @"kLastLoginUserId"
#define kLastLoginUserName  @"kLastLoginUserName"


@interface FAMainUser ()
// 从持久化数据中读取mainUser
+ (FAMainUser *)readFromDisk:(NSString *)userId;

// 持久化路径
+ (NSString *)persistPath:(NSString *)userId;

@end


static FAMainUser* _instance = nil;

@implementation FAMainUser


+ (FAMainUser *) getInstance {
    
	@synchronized(self) {
		if (_instance == nil) {
            // 看是否有最近的登录用户Id
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *userId = [defaults objectForKey:kLastLoginUserId];
            
            if (userId) {
                _instance = [FAMainUser readFromDisk:userId];
                if (!_instance) {
                    _instance = [[FAMainUser alloc] init]; // assignment not done here
#if TARGET_IPHONE_SIMULATOR     //如果是模拟器
                    _instance.selectedCityId = [NSNumber numberWithInt:290];
                    _instance.selectedCityName = @"北京";
#endif
                }
                
            } else {
                // 从未登录过的逻辑
                _instance = [[FAMainUser alloc] init];
#if TARGET_IPHONE_SIMULATOR     //如果是模拟器
                _instance.selectedCityId = [NSNumber numberWithInt:290];
                _instance.selectedCityName = @"北京";
#endif
            }
            _instance.selectedCityId = _instance.currentCityId;
            _instance.selectedCityName = _instance.currentCityName;
		}
	}
    
	return _instance;
}

+ (id) allocWithZone:(NSZone*) zone {
	@synchronized(self) {
		if (_instance == nil) {
			_instance = [super allocWithZone:zone];  // assignment and return on first allocation
			return _instance;
		}
	}
	return nil;
}

- (id) copyWithZone:(NSZone*) zone {
	return _instance;
}

- (id) init
{
	if (self = [super init]){
        self.userId = @"";
	}
    
	return self;
}

- (void) clear
{
    self.userId = @"";
    self.loginAccount = nil;
	self.md5Password = nil;
    self.latitude = nil;
    self.longitude = nil;
    self.currentCityId = nil;
    self.currentCityName = nil;
    self.selectedCityId = nil;
    self.selectedCityName = nil;
    // 暂时如此处理 注销登录 bug
	self.sessionKey = @"";
    self.weiboNickName = nil;
    self.isLogin = NO;
}

#pragma mark -
#pragma mark NSCoding methods

#pragma mark Public
- (void)persist {
    NSString *userId = self.userId;
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:userId forKey:kLastLoginUserId];
    [defaults synchronize];
	
	if (userId) {
        NSString *persistPath = [FAMainUser persistPath:userId];
        [NSKeyedArchiver archiveRootObject:self toFile:persistPath];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)logout {
	FAMainUser *mainUser = _instance;
     mainUser.isLogin = NO;
	[mainUser clear];
	NSString *userIdtmp = [self.userId copy];
    self.userId = nil;
	if (userIdtmp) {
        NSString *persistPath = [FAMainUser persistPath:userIdtmp];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        [fileMgr removeItemAtPath:persistPath error:nil];
	}
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults removeObjectForKey:kLastLoginUserId];
    
}

- (BOOL)isMainUserId:(NSString*)anUserId {
	// 在没有id的情况的, 将默认是mainuser
	if (!anUserId) {
		return TRUE;
	}
	
	if (!self.userId) {
		return FALSE;
	}
	
	return NSOrderedSame == [self.userId compare:anUserId] ? TRUE : FALSE;
}

// 从持久化数据中读取mainUser
+ (FAMainUser *)readFromDisk:(NSString *)userId{
    NSString *userFile = [FAMainUser persistPath:userId];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:userFile];
}

- (NSString*)sessionKey
{
    if(_sessionKey == nil)
        return @"";
    else
        return _sessionKey;
}

- (BOOL) checkLoginInfo
{
	if (self.sessionKey &&  self.sessionKey.length > 0) {
		return YES;
	}
	
	return NO;
}

// App Document 路径
+ (NSString *)documentPath{
    NSArray *searchPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [searchPath objectAtIndex:0];
    return path;
}

// 公共文件夹路径
+ (NSString *)commonPath{
    NSString *path = [[FAMainUser documentPath] stringByAppendingPathComponent:kCommonDir];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:path]) {
        NSError *error = nil;
        [fileMgr createDirectoryAtPath:path
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&error];
        if (error) {
            NSLog(@"创建 commonPath 失败 %@", error);
        }
    }
    
    return path;
}

// 用户路径
- (NSString *)userDocumentPath{
    NSString *path = [[FAMainUser documentPath] stringByAppendingPathComponent:self.userId];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:path]) {
        NSError *error = nil;
        [fileMgr createDirectoryAtPath:path
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&error];
        if (error) {
            NSLog(@"创建 userDocumentPath 失败 %@", error);
        }
    }
    
    return path;
}

+ (NSString *)persistPath:(NSString *)userId{
    NSString *dirPath = [[FAMainUser documentPath] stringByAppendingPathComponent:userId];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:dirPath]) {
        NSError *error = nil;
        [fileMgr createDirectoryAtPath:dirPath
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&error];
        if (error) {
            NSLog(@"创建 userDocumentPath 失败 %@", error);
        }
    }
    
    NSString *path = [dirPath stringByAppendingPathComponent:kMainUserFileName];
    return path;
}

- (NSString*)splashPath{
    NSString *dirPath = [[FAMainUser commonPath] stringByAppendingPathComponent:kSplashDir];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:dirPath]) {
        NSError *error = nil;
        [fileMgr createDirectoryAtPath:dirPath
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&error];
        if (error) {
            NSLog(@"创建 commonPath 失败 %@", error);
        }
    }
    
    NSString* path = [dirPath stringByAppendingPathComponent:kSplashName];
    return path;
}

- (NSString*)splashDataPath{
    NSString *dirPath = [[FAMainUser commonPath] stringByAppendingPathComponent:kSplashDir];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:dirPath]) {
        NSError *error = nil;
        [fileMgr createDirectoryAtPath:dirPath
           withIntermediateDirectories:YES
                            attributes:nil
                                 error:&error];
        if (error) {
            NSLog(@"创建 commonPath 失败 %@", error);
        }
    }
    
    NSString* path = [dirPath stringByAppendingPathComponent:kSplashData];
    return path;
}



@end
