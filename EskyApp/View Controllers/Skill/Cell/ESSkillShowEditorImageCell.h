//
//  ESSkillShowEditorImageCell
//  EskyApp
//
//  Created by jason on 14-1-7.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSkillShowEditorImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *testImage;

+ (ESSkillShowEditorImageCell *)cellFromXib;

-(UITableView *)getTableView;

@end
