//
//  RTSpinKitPulseAnimation.m
//  SpinKit
//
//  Created by Ramon Torres on 9/5/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitPulseAnimation.h"

@implementation RTSpinKitPulseAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color
{
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CALayer *circle = [CALayer layer];
    circle.frame = CGRectInset(CGRectMake(0.0, 0.0, size.width, size.height), 2.0, 2.0);
    circle.backgroundColor = color.CGColor;
    circle.anchorPoint = CGPointMake(0.5, 0.5);
    circle.opacity = 1.0;
    circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
    circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
    
    CAKeyframeAnimation *scaleAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    scaleAnim.values = @[
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)],
        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)]
    ];

    CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.values = @[@(1.0), @(0.0)];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.removedOnCompletion = NO;
    animGroup.beginTime = beginTime;
    animGroup.repeatCount = HUGE_VALF;
    animGroup.duration = 1.0;
    animGroup.animations = @[scaleAnim, opacityAnim];
    animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [layer addSublayer:circle];
    [circle addAnimation:animGroup forKey:@"spinkit-anim"];
}

@end
