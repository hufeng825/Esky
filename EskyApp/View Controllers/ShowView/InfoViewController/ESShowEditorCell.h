//
//  ESShowEditorCell.h
//  EskyApp
//
//  Created by jason on 14-1-4.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESShowEditorCell : UITableViewCell

@property (copy, nonatomic) void (^shareBlock)(id userInfo);
@property (copy, nonatomic) void (^loveBlock)(id userInfo);

@property (weak, nonatomic) IBOutlet UILabel *loveCountLabel;

+ (ESShowEditorCell *)cellFromXib;


@end
