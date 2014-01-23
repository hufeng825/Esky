//
//  HFTabBarViewController.m
//  HFTabBarController
//
//  Created by jason on 13-12-19.
//  Copyright (c) 2013年 taobao. All rights reserved.
//

#import "HFTabBarViewController.h"

#define kNGDefaultAnimationDuration           0.25f


@interface HFTabBarViewController ()
{
    BOOL _animationActive;
}

@property (nonatomic, readonly) UIViewAnimationOptions currentActiveAnimationOptions;
@property (nonatomic, strong) UIViewController *currentViewController;


@end

@implementation HFTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _animationDuration = kNGDefaultAnimationDuration;
        _animationActive = YES;
        _selectedIndex = 0;
    }
    return self;
}

- (UIViewController *)selectedViewController {
    NSAssert(self.selectedIndex < self.subViewControllers.count, @"Selected index is invalid");
    
    id selectedViewController = [self.subViewControllers objectAtIndex:self.selectedIndex];
    
    if (selectedViewController == [NSNull null]) {
        return nil;
    }
    
    return selectedViewController;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSAssert(self.delegate != nil, @"No delegate set");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    __weak __typeof(self)weakSelf=self;
    [[NSNotificationCenter defaultCenter] addObserverForName:kHFTabBarNotificationFlag                                                                            object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self cycleFromViewControllerToIndex:((HFTabBarIndex *)note.object).toIndex  withCompletionBlock:nil];
        if ( [_delegate respondsToSelector:@selector(tabBarController:selectViewController:atIndex:) ] && self.delegate) {
            [_delegate tabBarController:weakSelf selectViewController:weakSelf.currentViewController atIndex:((HFTabBarIndex *)note.object)];
        }
    }];

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)setSubViewControllers:(NSArray *)subViewControllers{
    if (subViewControllers != _subViewControllers && subViewControllers ) {
        _subViewControllers = [subViewControllers copy];
        [self setSelectedIndex:_selectedIndex];
    }
}


- (void)setSelectedIndex:(NSInteger)selectedIndex {
//    if (selectedIndex != _selectedIndex)
    {
        _selectedIndex = selectedIndex;
        [self cycleFromViewControllerToIndex:selectedIndex withCompletionBlock:nil];
        [self.tabBar selectItemAtIndex:selectedIndex];
        [self.tabBar deselectSelectedItemWithOut:selectedIndex];
    }
}


- (void)cycleFromViewControllerToIndex:(NSInteger )newIndex withCompletionBlock:(void (^)(BOOL finished))completionBlock{
    
    UIViewController *oldVC = self.currentViewController;
    UIViewController *newVC = [self.subViewControllers objectAtIndex:newIndex];
    
    // Do nothing if we are attempting to swap to the same view controller
    if (newVC == oldVC) return;
    
    // Check the newVC is non-nil otherwise expect a crash: NSInvalidArgumentException
    if (newVC) {
        
        // Set the new view controller frame (in this case to be the size of the available screen bounds)
        // Calulate any other frame animations here (e.g. for the oldVC)
        newVC.view.frame = CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMinY(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
        
        
        // Check the oldVC is non-nil otherwise expect a crash: NSInvalidArgumentException
        if (oldVC) {
            
            // Start both the view controller transitions
            [oldVC willMoveToParentViewController:nil];
            [self addChildViewController:newVC];
            
            newVC.view.frame = CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMinY(self.view.bounds), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
            
            if (_animationActive) {
                [self transitionFromViewController:oldVC toViewController:newVC duration:_animationDuration options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionTransitionCrossDissolve animations:^{} completion:^(BOOL finished) {
                    [oldVC removeFromParentViewController];
                    [newVC didMoveToParentViewController:self];
                }];
            }else{
                [oldVC removeFromParentViewController];
                [newVC didMoveToParentViewController:self];
            }
            
           
            
            self.currentViewController = newVC;
            // Store a reference to the current controller
            if (completionBlock) {
                completionBlock(YES);
            }
            
        } else {
            
            // Otherwise we are adding a view controller for the first time
            // Start the view controller transition
            [self addChildViewController:newVC];
            
            // Add the new view controller view to the ciew hierarchy
            [self.view addSubview:newVC.view];
            
            // End the view controller transition
            [newVC didMoveToParentViewController:self];
            self.currentViewController = newVC;
            // Store a reference to the current controller
            
            if (completionBlock) {
                completionBlock(YES);
            }
        }
    }
    
    [self.view bringSubviewToFront:self.tabBar];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
