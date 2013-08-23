//
//  YNImageWindow.h
//  YNImageWindow
//
//  Created by 杨宁 on 13-8-23.
//  Copyright (c) 2013年 numbbuaa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNImageWindow : UIWindow<UIScrollViewDelegate, UIGestureRecognizerDelegate>

- (void)showFromView:(UIView *)sourceView withImage:(UIImage *)image;

- (void)removeImageWindow;

@end
