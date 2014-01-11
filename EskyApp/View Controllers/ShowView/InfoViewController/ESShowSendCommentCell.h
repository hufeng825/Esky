//
//  ESShowSendCommentCell.h
//  EskyApp
//
//  Created by jason on 14-1-5.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESShowSendCommentCell : UITableViewCell

@property (copy, nonatomic) void (^editBlock)(UITextView *textView);

+ (ESShowSendCommentCell *)cellFromXib;

@end
