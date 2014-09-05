//
//  RTSpinKit9CubeGridAnimation.m
//  SpinKit
//
//  Created by Ramon Torres on 9/5/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKit9CubeGridAnimation.h"

@implementation RTSpinKit9CubeGridAnimation

-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color
{
    NSTimeInterval beginTime = CACurrentMediaTime();
    
    CGFloat squareSize = size.width / 3;

    for (NSInteger sum = 0; sum < 5; sum++)
    {
        for (NSInteger x = 0; x < 3; x++)
        {
            for (NSInteger y = 0; y < 3; y++)
            {
                if (x + y == sum)
                {
                    CALayer *square = [CALayer layer];
                    square.frame = CGRectMake(x * squareSize, y * squareSize, squareSize, squareSize);
                    square.backgroundColor = color.CGColor;
                    square.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
                    
                    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                    anim.removedOnCompletion = NO;
                    anim.repeatCount = HUGE_VALF;
                    anim.duration = 1.5;
                    anim.beginTime = beginTime + (0.1 * sum);
                    anim.keyTimes = @[@(0.0), @(0.4), @(0.6), @(1.0)];
                    
                    anim.timingFunctions = @[
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                     ];

                    anim.values = @[
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                        [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]
                    ];
                    
                    [layer addSublayer:square];
                    [square addAnimation:anim forKey:@"spinkit-anim"];
                }
            }
        }
    }
}

@end
