//
//  RTSpinKitCircleFlipAnimation.m
//  SpinKit
//
//  Created by Ramon Torres on 9/4/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitCircleFlipAnimation.h"
#import "RTSpinKitUtils.h"

@implementation RTSpinKitCircleFlipAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color
{
    CALayer *circle = [CALayer layer];
    circle.frame = CGRectInset(CGRectMake(0.0, 0.0, size.width, size.height), 2.0, 2.0);
    circle.backgroundColor = color.CGColor;
    circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
    circle.anchorPoint = CGPointMake(0.5, 0.5);
    circle.anchorPointZ = 0.5;
    circle.shouldRasterize = YES;
    circle.rasterizationScale = [[UIScreen mainScreen] scale];
    [layer addSublayer:circle];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    anim.removedOnCompletion = NO;
    anim.repeatCount = HUGE_VALF;
    anim.duration = 1.2;
    anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];
    
    anim.timingFunctions = @[
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
    ];

    anim.values = @[
        [NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, 0, 0, 0, 0)],
        [NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, M_PI, 0.0, 1.0, 0.0)],
        [NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, M_PI, 0.0, 0.0, 1.0)]
    ];
    
    [circle addAnimation:anim forKey:@"spinkit-anim"];
}

@end
