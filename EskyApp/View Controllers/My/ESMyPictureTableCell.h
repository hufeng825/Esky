//
//  ESMyPictureTableCell.h
//  EskyApp
//
//  Created by jason on 14-1-24.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESMyPictureTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong,nonatomic) NSIndexPath *indexPath;
+ (ESMyPictureTableCell *)cellFromXib;

@end
