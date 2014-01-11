//
//  ESPublishViewController.m
//  EskyApp
//
//  Created by jason on 14-1-10.
//  Copyright (c) 2014年 fashion. All rights reserved.
//

#import "ESPublishViewController.h"
#import "FaceBoard.h"
#import "ESCommonMacros.h"
@interface ESPublishViewController ()

@property (weak,   nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (weak,   nonatomic) IBOutlet UITextView *contextView;
@property (strong, nonatomic) FaceBoard *faceBoard;
@property (weak, nonatomic) IBOutlet UIImageView *sendImageView;
@property (strong, nonatomic) UIImage *sendimage;
- (IBAction)ejmoBtlick:(id)sender;

@end

@implementation ESPublishViewController

- (id)initWithImage:(UIImage *)image
{
    NSString *clssName = NSStringFromClass([self class]);
    
    self = [super initWithNibName:clssName bundle:Nil];
    if (self) {
        _sendimage = image;
    }
    return self;
}

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
    // Do any additional setup after loading the view from its nib.
    self.title = @"发布";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage)];
    _faceBoard = [[FaceBoard alloc]init];
    if (self.isViewLoaded) {
        [self.contextView becomeFirstResponder];
        _sendImageView.image = _sendimage;
    }

}

- (void)sendMessage
{
    HFAlert(@"发送ing");
}


- (void)stretchScrollViewContext
{
    [self.bgScrollView setContentSize:CGSizeMake(self.view.frame.size.width,self.view.frame.size.height+50.f) ];
}

- (void)resetScrollViewContext
{
    [self.bgScrollView setContentSize:self.view.frame.size];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self resetScrollViewContext];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ejmoBtlick:(id)sender {
    [self.contextView resignFirstResponder];
    _faceBoard.inputTextView = self.contextView;
    self.contextView.inputView = _faceBoard ;
    [self.contextView becomeFirstResponder];
}
@end
