//
//  ESEditorSectionView.h
//  EskyApp
//
//  Created by jason on 14-1-5.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESSkillEditorSectionView : UIView



@property (weak, nonatomic) IBOutlet UIImageView *headIconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImageView;

+ (ESSkillEditorSectionView *)viewFromXib;



@end
