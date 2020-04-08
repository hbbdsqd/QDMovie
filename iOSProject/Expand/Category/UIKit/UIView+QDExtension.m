//
//  UIView+QDExtension.m
//  iOSProject
//
//  Created by 苏秋东 on 2019/3/13.
//  Copyright © 2019 苏秋东. All rights reserved.
//

#import "UIView+QDExtension.h"

@implementation UIView (QDExtension)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint) origin {
    return self.frame.origin;
}

- (void) setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize) size {
    return self.frame.size;
}

+ (UIViewAnimationOptions)animationOptionsWithCurve:(UIViewAnimationCurve)curve {
    switch(curve) {
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
    }
}

static const void *kLoadingViewKey = @"LoadingViewKey";

- (void) addLoadingView {
    [self addLoadingViewWithText:@"Loading..."];
}

- (void) addLoadingViewWithText:(NSString *)text {
    [self removeLoadingView];
    
    UIView *loadingView = [[UIView alloc] initWithFrame:self.bounds];
    [loadingView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [loadingView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    objc_setAssociatedObject(self, kLoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.font = [UIFont systemFontOfSize:15.0];
    loadingLabel.textColor = [UIColor blackColor];
    [loadingLabel setText:text];
    [loadingLabel sizeToFit];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [activityIndicator startAnimating];
    activityIndicator.left = (self.width - activityIndicator.width - loadingLabel.width - 5.0) / 2;
    activityIndicator.centerY = self.centerY;
    [loadingView addSubview:activityIndicator];
    
    loadingLabel.left = (self.width - activityIndicator.width - loadingLabel.width - 5.0) / 2 + activityIndicator.width + 5.0;
    loadingLabel.centerY = self.centerY;
    loadingLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [loadingView addSubview:loadingLabel];
    
    [self addSubview:loadingView];
}

- (void) removeLoadingView {
    UIView *loadingView = objc_getAssociatedObject(self, kLoadingViewKey);
    [loadingView removeFromSuperview];
}


- (instancetype)cornerAllCornersWithCornerRadius:(CGFloat)cornerRadius {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    self.layer.contentsScale = [[UIScreen mainScreen] scale];
    return self;
}


- (instancetype)cornerByRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.layer.contentsScale = [[UIScreen mainScreen] scale];
    return self;
}
@end
