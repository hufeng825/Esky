//
//  ESShowEditorCell.h
//  EskyApp
//
//  Created by jason on 14-1-4.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESShowEditorCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *testImage;
@property (copy, nonatomic) void (^shareBlock)(id userInfo);

+ (ESShowEditorCell *)cellFromXib;


@end
