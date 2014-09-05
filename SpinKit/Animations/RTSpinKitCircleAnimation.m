//
//  RTSpinKitCircleAnimation.m
//  SpinKit
//
//  Created by Ramon Torres on 9/5/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitCircleAnimation.h"

@implementation RTSpinKitCircleAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color
{
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat radius = size.width / 2;
    CGFloat squareSize = size.width / 6;

    for (NSInteger i=0; i < 12; i+=1) {
        CALayer *square = [CALayer layer];
        
        CGFloat angle = i * (M_PI_2/3.0);
        CGFloat x = radius + sinf(angle) * radius;
        CGFloat y = radius - cosf(angle) * radius;
        square.frame = CGRectMake(x, y, squareSize, squareSize);
        square.backgroundColor = color.CGColor;
        square.anchorPoint = CGPointMake(0.5, 0.5);
        square.opacity = 0.0;

        CATransform3D transform = CATransform3DIdentity;
        transform = CATransform3DRotate(transform, angle, 0, 0, 1.0);
        square.transform = transform;

        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        anim.removedOnCompletion = NO;
        anim.repeatCount = HUGE_VALF;
        anim.duration = 1.0;
        anim.beginTime = beginTime + (0.084 * i);
        anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];
        
        anim.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];
        
        anim.values = @[@(1.0), @(0.0), @(0.0)];

        [layer addSublayer:square];
        [square addAnimation:anim forKey:@"spinkit-anim"];
    }
}

@end
