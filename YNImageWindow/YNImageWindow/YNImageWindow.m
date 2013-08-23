//
//  YNImageWindow.m
//  YNImageWindow
//
//  Created by 杨宁 on 13-8-23.
//  Copyright (c) 2013年 numbbuaa. All rights reserved.
//

#import "YNImageWindow.h"
#import "AppDelegate.h"

@interface YNImageWindow ()
{
    UIScrollView *sv;
    
    UIImageView *imageView;
    
    CGRect originalRect;
}

@end

@implementation YNImageWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.windowLevel = UIWindowLevelAlert;
        self.backgroundColor = [UIColor blackColor];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeImageWindow)];
        [self addGestureRecognizer:singleTap];
        [singleTap release];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetScale)];
        doubleTap.delegate = self;
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        [doubleTap release];
        
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)showFromView:(UIView *)sourceView withImage:(UIImage *)image
{
    UIView *superView = [sourceView superview];
    
    //nil表示转换到window坐标系统
    CGRect rect = [superView convertRect:sourceView.frame toView:nil];
    
    originalRect = rect;
    
    NSLog(@"sourceview frame(%f, %f, %f, %f) convert to (%f, %f, %f, %f)", sourceView.frame.origin.x, sourceView.frame.origin.y, sourceView.frame.size.width, sourceView.frame.size.height, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    
    sv = [[UIScrollView alloc] initWithFrame:self.bounds];
    sv.delegate = self;
    sv.maximumZoomScale = 2.0;
    
    imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = rect;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
//    [self addSubview:imageView];
    [sv addSubview:imageView];
    
    [self addSubview:sv];
    [sv release];
    
    [self showAnimation:imageView];
    
    [self retain];
    
    [self makeKeyAndVisible];
}

- (void)removeImageWindow
{
    sv.zoomScale = 1.0f;
    [self removeAnimation:imageView];
}

- (void)resetScale
{
    if (sv.zoomScale > 1.0f)
    {
        [sv setZoomScale:1.0f animated:YES];
    }
    else
    {
        [sv setZoomScale:2.0f animated:YES];
    }
}

#pragma mark -
#pragma mark Animation

- (void)showAnimation:(UIView *)view
{
    [UIView animateWithDuration:0.3 animations:^{
        view.frame = [UIScreen mainScreen].bounds;
    } completion:NULL];
}

- (void)removeAnimation:(UIView *)view
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        view.frame = originalRect;
    } completion:^(BOOL finished){
        self.hidden = YES;
        [self release];
    }];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imageView;
}

#pragma mark - 
#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
