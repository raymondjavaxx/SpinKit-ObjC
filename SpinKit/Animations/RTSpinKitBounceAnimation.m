//
//  RTSpinKitBounceAnimation.m
//  SpinKit
//
//  Created by Ramon Torres on 9/4/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitBounceAnimation.h"

@implementation RTSpinKitBounceAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color
{
    NSTimeInterval beginTime = CACurrentMediaTime();

    for (NSInteger i=0; i < 2; i+=1) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectInset(CGRectMake(0.0, 0.0, size.width, size.height), 2.0, 2.0);
        circle.backgroundColor = color.CGColor;
        circle.anchorPoint = CGPointMake(0.5, 0.5);
        circle.opacity = 0.6;
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

        [layer addSublayer:circle];
        [circle addAnimation:anim forKey:@"spinkit-anim"];
    }
}

@end
