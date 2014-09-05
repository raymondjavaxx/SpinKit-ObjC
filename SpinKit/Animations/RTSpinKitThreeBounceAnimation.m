//
//  RTSpinKitThreeBounceAnimation.m
//  SpinKit
//
//  Created by Ramon Torres on 9/5/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitThreeBounceAnimation.h"

@implementation RTSpinKitThreeBounceAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color
{
    NSTimeInterval beginTime = CACurrentMediaTime();

    CGFloat offset = size.width / 8;
    CGFloat circleSize = offset * 2;
    
    for (NSInteger i=0; i < 3; i+=1) {
        CALayer *circle = [CALayer layer];
        circle.frame = CGRectMake(i * 3 * offset, size.height / 2, circleSize, circleSize);
        circle.backgroundColor = color.CGColor;
        circle.anchorPoint = CGPointMake(0.5, 0.5);
        circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
        circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        anim.removedOnCompletion = NO;
        anim.repeatCount = HUGE_VALF;
        anim.duration = 1.5;
        anim.beginTime = beginTime + (0.25 * i);
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
