//
//  UIWebImageView.m
//  Esquire
//
//  Created by jason on 13-10-24.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "UIWebImageView.h"

@implementation UIWebImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)setImageWithURLStr:(NSString *)urlStr {
    [self setImageWithURLStr:urlStr placeholderImage:nil];
}

- (void)setImageWithURLStr:(NSString *)urlStr
       placeholderImage:(UIImage *)placeholderImage
{

    __block UIImageView *viewImage = self;
    [self setImageWithURLStr:urlStr placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
    {
        viewImage.image  = [image imageByScalingToSize:viewImage.frame.size];
        [
         [EGOCache globalCache]setImage:image forKey:
         [NSString stringWithFormat:@"%lu",(unsigned long)[urlStr hash]
          ]
         ];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
      {
          if (placeholderImage)
          {
              viewImage.image = placeholderImage;
          }
      }];
}




- (void)setImageWithURLStr:(NSString *)urlStr
              placeholderImage:(UIImage *)placeholderImage
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr ]];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    UIImage *image = [[EGOCache globalCache] imageForKey:[NSString stringWithFormat:@"%lu",(unsigned long)[urlStr hash]] ];
    
    if (image) {
        self.image  = [image imageByScalingToSize:self.frame.size];
    }
    else
    {
        [self setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            success(request,response,image);
            
            [[EGOCache globalCache]setImage:image forKey:
             [NSString stringWithFormat:@"%lu",(unsigned long)[urlStr hash]]];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
        {
            failure(request,response,error);
        }
         ];
    }
}


@end

