//
//  UIWebImageView.h
//  Esquire
//
//  Created by jason on 13-10-24.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

//基于AF 添加了本地缓存图片 默认过期时间是一天
//优化了大图卡顿问题 压缩了图片空间


@interface UIWebImageView : UIImageView

- (void)setImageWithURLStr:(NSString *)url ;

- (void)setImageWithURLStr:(NSString *)urlStr
          placeholderImage:(UIImage *)placeholderImage;

- (void)setImageWithURLStr:(NSString *)urlStr
          placeholderImage:(UIImage *)placeholderImage
                   success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                   failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure;



@end
