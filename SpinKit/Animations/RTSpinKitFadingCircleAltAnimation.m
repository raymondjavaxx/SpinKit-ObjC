//
//  RTSpinKitFadingCircleAltAnimation.m
//  SpinKit
//
//  Created by Ramon Torres on 9/5/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitFadingCircleAltAnimation.h"

static const CGFloat kRTSpinKitDegToRad = 0.0174532925;

@implementation RTSpinKitFadingCircleAltAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color {
        NSTimeInterval beginTime = CACurrentMediaTime() ;

        CGFloat radius =  size.width / 2;

        for (NSInteger i=0; i < 12;  i+=1) {
            CALayer *circle = [CALayer layer];
            circle.backgroundColor = color.CGColor;
            circle.anchorPoint = CGPointMake(0.5, 0.5);
            circle.frame = CGRectMake(radius + cosf(kRTSpinKitDegToRad * (30.0 * i)) * radius , radius + sinf(kRTSpinKitDegToRad * (30.0 * i)) * radius, radius / 2, radius / 2);
            circle.shouldRasterize = YES;
            circle.rasterizationScale = [[UIScreen mainScreen] scale];
            circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;

            CAKeyframeAnimation* transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];

            transformAnimation.values = @[
                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]
            ];

            CAKeyframeAnimation* opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
            
            opacityAnimation.values = @[
                @(1.0),
                @(0.0)
            ];

            CAAnimationGroup* animationGroup = [[CAAnimationGroup alloc] init];
            animationGroup.removedOnCompletion = NO;
            animationGroup.repeatCount = HUGE_VALF;
            animationGroup.duration = 1.2;
            animationGroup.beginTime = beginTime - (1.2 - (0.1 * i));
            animationGroup.animations = @[transformAnimation, opacityAnimation];
            [circle addAnimation:animationGroup forKey:@"spinkit-anim"];
            [layer addSublayer:circle];
        }
}

@end
