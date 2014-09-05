//
//  RTSpinKitWordPressAnimation.m
//  SpinKit
//
//  Created by Ramon Torres on 9/5/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitWordPressAnimation.h"

@implementation RTSpinKitWordPressAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color
{
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CALayer *spinner = [CALayer layer];
    spinner.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    spinner.anchorPoint = CGPointMake(0.5, 0.5);
    spinner.transform = CATransform3DIdentity;
    spinner.backgroundColor = color.CGColor;
    spinner.shouldRasterize = YES;
    spinner.rasterizationScale = [[UIScreen mainScreen] scale];
    [layer addSublayer:spinner];

    CAKeyframeAnimation *spinnerAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    spinnerAnim.removedOnCompletion = NO;
    spinnerAnim.repeatCount = HUGE_VALF;
    spinnerAnim.duration = 1.0;
    spinnerAnim.beginTime = beginTime;
    spinnerAnim.keyTimes = @[@(0.0), @(0.25), @(0.5), @(0.75), @(1.0)];
    
    spinnerAnim.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]
    ];

    spinnerAnim.values = @[
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1.0)],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0, 0, 1.0)],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1.0)],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3 * M_PI_2, 0, 0, 1.0)],
        [NSValue valueWithCATransform3D:CATransform3DMakeRotation(2 * M_PI, 0, 0, 1.0)]
    ];

    [spinner addAnimation:spinnerAnim forKey:@"spinkit-anim"];

    CAShapeLayer *circleMask = [CAShapeLayer layer];
    circleMask.frame = spinner.bounds;
    circleMask.fillColor = [UIColor blackColor].CGColor;
    circleMask.anchorPoint = CGPointMake(0.5, 0.5);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, spinner.frame);

    CGFloat circleSize = size.width * 0.25;
    CGPathAddEllipseInRect(path, nil, CGRectMake(CGRectGetMidX(spinner.frame) - circleSize/2, 3.0, circleSize, circleSize));
    CGPathCloseSubpath(path);
    circleMask.path = path;
    circleMask.fillRule = kCAFillRuleEvenOdd;
    CGPathRelease(path);

    spinner.mask = circleMask;
}

@end
