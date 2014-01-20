//
//  HFCycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by jason on 1/4/14.
//  Copyright (c) 2014 taobao. All rights reserved.
//

#import "HFCycleScrollView.h"

@interface HFCycleScrollView()
@property (nonatomic,assign) NSInteger preNum;
@end

@implementation HFCycleScrollView

@synthesize scrollView ;
@synthesize currentPage ;
@synthesize datasource ;
@synthesize delegate ;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delegate = self;
    scrollView.scrollEnabled = NO;
    scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:scrollView];
    
    scrollView.directionalLockEnabled = YES;
    _curPage = 0;
    
    scrollView.alwaysBounceHorizontal = YES;
    self.scrollView.delaysContentTouches = NO;
    self.scrollView.canCancelContentTouches = NO;
    _preNum = HUGE_VAL;
    
    scrollView.alwaysBounceVertical = YES ;
    
    UISwipeGestureRecognizer * Swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    Swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:Swipeleft];
    
    UISwipeGestureRecognizer * Swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    Swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:Swiperight];
    
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
//    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:YES];

    //Do what you want here
    _curPage = [self validPageValue:_curPage+1];
    [self loadData];
}

-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    //Do what you want here
//    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:YES];
    _curPage = [self validPageValue:_curPage-1];
    [self loadData];
}

- (void)setDataource:(id<HFCycleScrollViewDatasource>)newdatasourcen
{
    datasource = newdatasourcen;
    [self reloadData];
}

- (void)reloadData
{
    _totalPages = [datasource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    [self loadData];
}

- (void)loadData
{
    //从scrollView上移除所有的subview
    NSArray *subViews = [scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < 3; i++) {
        UIView *v = [_curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [scrollView addSubview:v];
    }
    
    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
}


- (void)getDisplayImagesWithCurpage:(int)page {
    
    int pre = [self validPageValue:_curPage-1];
    int last = [self validPageValue:_curPage+1];
    
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    [_curViews removeAllObjects];
    
    [_curViews addObject:[datasource pageAtIndex:pre]];
    [_curViews addObject:[datasource pageAtIndex:page]];
    [_curViews addObject:[datasource pageAtIndex:last]];
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}



- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 3; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
            [scrollView addSubview:v];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)setBgContentOffsetAnimation:(CGFloat)Offsetx OffsetY:(CGFloat)OffsetY {
    [UIView animateWithDuration:1 delay:.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.scrollView.contentOffset = CGPointMake(Offsetx, OffsetY);
    } completion:nil ];
}


- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int x = aScrollView.contentOffset.x;
    

    //往下翻一张
    if(x >= (2*self.frame.size.width)) {
        _curPage = [self validPageValue:_curPage+1];
        [self loadData];
    }
    
    //往上翻
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage-1];
        [self loadData];
    }
    if ( delegate && [delegate respondsToSelector:@selector(scrollToCurrentIndex:)] && _curPage != _preNum ) {
        [delegate scrollToCurrentIndex:_curPage];
        _preNum = _curPage;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:YES];
    
}

@end
