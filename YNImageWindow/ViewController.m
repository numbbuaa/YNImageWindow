//
//  ViewController.m
//  YNImageWindow
//
//  Created by 杨宁 on 13-8-23.
//  Copyright (c) 2013年 numbbuaa. All rights reserved.
//

#import "ViewController.h"
#import "YNImageWindow.h"

@interface ViewController ()

@end

@implementation ViewController

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
	// Do any additional setup after loading the view.
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, 360)];
    containerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:containerView];
    [containerView release];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test.jpg"]];
    iv.frame = CGRectMake(60, 60, 150, 240);
    iv.userInteractionEnabled = YES;
    [containerView addSubview:iv];
    [iv release];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage:)];
    [iv addGestureRecognizer:tap];
    [tap release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showImage:(UIGestureRecognizer *)gesture
{
    YNImageWindow *imageWindow = [[YNImageWindow alloc] init];
    [imageWindow showFromView:[gesture view] withImage:[UIImage imageNamed:@"test.jpg"]];
    [imageWindow release];
}

@end
