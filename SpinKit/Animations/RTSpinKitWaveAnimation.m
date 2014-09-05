//
//  RTSpinKitWaveAnimation.m
//  SpinKit
//
//  Created by Ramon Torres on 9/5/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitWaveAnimation.h"

@implementation RTSpinKitWaveAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color
{
    NSTimeInterval beginTime = CACurrentMediaTime() + 1.2;
    CGFloat barWidth = size.width / 5.0;

    for (NSInteger i=0; i < 5; i+=1) {
        CALayer *bar = [CALayer layer];
        bar.backgroundColor = color.CGColor;
        bar.frame = CGRectMake(barWidth * i, 0.0, barWidth - 3.0, size.height);
        bar.transform = CATransform3DMakeScale(1.0, 0.3, 0.0);

        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        anim.removedOnCompletion = NO;
        anim.beginTime = beginTime - (1.2 - (0.1 * i));
        anim.duration = 1.2;
        anim.repeatCount = HUGE_VALF;

        anim.keyTimes = @[@(0.0), @(0.2), @(0.4), @(1.0)];

        anim.timingFunctions = @[
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
            [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
        ];

        anim.values = @[
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.4, 0.0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.4, 0.0)],
            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.4, 0.0)]
        ];

        [bar addAnimation:anim forKey:@"spinkit-anim"];

        [layer addSublayer:bar];
    }
}

@end
