//
//  RTSpinKitChasingDotsAnimation.m
//  SpinKit
//
//  Created by Ramon Torres on 9/5/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitChasingDotsAnimation.h"

@implementation RTSpinKitChasingDotsAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color
{
    NSTimeInterval beginTime = CACurrentMediaTime();

    CALayer *spinner = [CALayer layer];
    spinner.frame = CGRectMake(0.0, 0.0, size.width, size.height);
    spinner.anchorPoint = CGPointMake(0.5, 0.5);
    spinner.transform = CATransform3DIdentity;
    spinner.shouldRasterize = YES;
    spinner.rasterizationScale = [[UIScreen mainScreen] scale];
    [layer addSublayer:spinner];

    CAKeyframeAnimation *spinnerAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    spinnerAnim.removedOnCompletion = NO;
    spinnerAnim.repeatCount = HUGE_VALF;
    spinnerAnim.duration = 2.0;
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

    [spinner addAnimation:spinnerAnim forKey:@"spinner-anim"];
    
    for (NSInteger i=0; i < 2; i+=1) {
        CALayer *circle = [CALayer layer];
        CGFloat offset = size.width * 0.3 * i;
        circle.frame = CGRectOffset(CGRectApplyAffineTransform(CGRectMake(0.0, 0.0, size.width, size.height), CGAffineTransformMakeScale(0.6, 0.6)), offset, offset);
        circle.backgroundColor = color.CGColor;
        circle.anchorPoint = CGPointMake(0.5, 0.5);
        circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
        circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        anim.removedOnCompletion = NO;
        anim.repeatCount = HUGE_VALF;
        anim.duration = 2.0;
        anim.beginTime = beginTime - (1.0 * i);
        anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];
        
        anim.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        
        anim.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]
        ];

        [spinner addSublayer:circle];
        [circle addAnimation:anim forKey:@"spinkit-anim"];
    }
}

@end
