//
//  HFCycleScrollView.h
//
//  Created by jason on 4/1/14.
//  Copyright (c) 2014 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFCycleScrollViewDelegate;
@protocol HFCycleScrollViewDatasource;

@interface HFCycleScrollView : UIView<UIScrollViewDelegate>
{
    NSInteger _totalPages;
    NSInteger _curPage;
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign,setter = setDataource:) id<HFCycleScrollViewDatasource> datasource;
@property (nonatomic,weak,setter = setDelegate:) id<HFCycleScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index;

@end

@protocol HFCycleScrollViewDelegate <NSObject>

@optional
//- (void)didClickPage:(HFCycleScrollView *)csView atIndex:(NSInteger)index;
- (void)scrollToCurrentIndex:(NSInteger)index;
@end

@protocol HFCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end
