//
//  ESChoseModuleViewController.m
//  EskyApp
//
//  Created by jason on 13-12-10.
//  Copyright (c) 2013年 fashion. All rights reserved.
//

#import "ESChoseModuleViewController.h"
#import "CSAnimation.h"

@interface ESChoseModuleViewController ()

@property (weak, nonatomic) IBOutlet UIButton *manBt;
@property (weak, nonatomic) IBOutlet UIButton *womanBt;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@end

@implementation ESChoseModuleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setSubViewHidden:YES];
    // Do any additional setup after loading the view from its nib.
 
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startAnimation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSubViewHidden:(BOOL)isHidden
{
    [_womanBt setHidden:isHidden];
    [_manBt setHidden:isHidden];
    [_hintLabel setHidden:isHidden];
}


- (void)startCanvasAnimationWithObject:(id)object
                              duration:(NSTimeInterval)duration
                                 delay:(NSTimeInterval)delay
                                  type:(CSAnimationType)type
{
    Class <CSAnimation> class = [CSAnimation classForAnimationType:type];
    [class performAnimationOnView:object duration:duration delay:delay];
}


- (void)startAnimation
{
    // Do any additional setup after loading the view from its nib.
    [self setSubViewHidden:NO];
    [self startCanvasAnimationWithObject:_manBt duration:.8 delay:0 type:CSAnimationTypeZoomOut];
    [self startCanvasAnimationWithObject:_womanBt duration:.8 delay:0 type:CSAnimationTypeZoomOut];
    [self startCanvasAnimationWithObject:_hintLabel duration:.8 delay:0 type:CSAnimationTypeSlideDown];

}


- (void)dealloc
{
    NSLog(@"d");
}
#pragma mark BtClicked

- (IBAction)manBtClicked:(id)sender{
    [[FAThemeManager sharedManager] setThemeName:@"man"] ;
    [self goBack];
}

- (IBAction)womanBtClicked:(id)sender {
    [[FAThemeManager sharedManager] setThemeName:@"woman"] ;
    [self goBack];
}


@end
