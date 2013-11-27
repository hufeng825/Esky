//
//  UIDevice+Additions.h
//  Esquire
//
//  Created by jason on 13-11-15.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Additions)

// 获取MAC地址
+ (NSString *)macAddress;

// 获取机器型号
+ (NSString *)machineModel;

// 设备可用空间
// freespace/1024/1024/1024 = B/KB/MB/14.02GB
+(NSNumber *)freeSpace;
// 设备总空间
+(NSNumber *)totalSpace;
// 获取运营商信息
+ (NSString *)carrierName;
// 获取运营商代码
+ (NSString *)carrierCode;
//获取电池电量
+ (CGFloat) getBatteryValue;
//获取电池状态
+ (NSInteger) getBatteryState;

// 内存硬盘信息
+ (NSString *)getFreeMemory;
+ (NSString *)getDiskUsed;



@end
