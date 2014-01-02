//
//  RTSpinKitView.m
//  SpinKit
//
//  Created by Ramon Torres on 1/1/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitView.h"

@interface RTSpinKitView ()
@property (nonatomic, assign) RTSpinKitViewStyle style;
@property (nonatomic, assign) BOOL stopped;
@end

static CATransform3D RTSpinKit3DRotationWithPerspective(CGFloat perspective,
                                                        CGFloat angle,
                                                        CGFloat x,
                                                        CGFloat y,
                                                        CGFloat z)
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    return CATransform3DRotate(transform, angle, x, y, z);
}

@implementation RTSpinKitView

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style {
    self = [super init];
    if (self) {
        _style = style;

        [self sizeToFit];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        if (style == RTSpinKitViewStylePlane) {
            CALayer *plane = [CALayer layer];
            plane.frame = CGRectInset(self.bounds, 10.0, 10.0);
            plane.backgroundColor = [[UIColor blackColor] CGColor];
            plane.anchorPoint = CGPointMake(0.5, 0.5);
            plane.anchorPointZ = 0.5;
            [self.layer addSublayer:plane];

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
                [NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, M_PI, 0.0, 1.0,0.0)],
                [NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, M_PI, 0.0, 0.0,1.0)]
            ];

            [plane addAnimation:anim forKey:@"spinkit-anim"];
        }
        else if (style == RTSpinKitViewStyleBounce) {
            NSTimeInterval beginTime = CACurrentMediaTime();

            for (NSInteger i=0; i < 2; i+=1) {
                CALayer *circle = [CALayer layer];
                circle.frame = CGRectInset(self.bounds, 10.0, 10.0);
                circle.backgroundColor = [[UIColor grayColor] CGColor];
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

                [self.layer addSublayer:circle];
                [circle addAnimation:anim forKey:@"spinkit-anim"];
            }
        }
        else if (style == RTSpinKitViewStyleWave) {
            NSTimeInterval beginTime = CACurrentMediaTime() + 1.2;
            CGFloat barWidth = CGRectGetWidth(self.bounds) / 5.0;
    
            for (NSInteger i=0; i < 5; i+=1) {
                CALayer *layer = [CALayer layer];
                layer.backgroundColor = [[UIColor grayColor] CGColor];
                layer.frame = CGRectMake(barWidth * i, 0.0, barWidth - 3.0, CGRectGetHeight(self.bounds));
                layer.transform = CATransform3DMakeScale(1.0, 0.4, 0.0);

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
                
                [self.layer addSublayer:layer];
                [layer addAnimation:anim forKey:@"spinkit-anim"];
            }
        }
        else if (style == RTSpinKitViewStylePulse) {
            NSTimeInterval beginTime = CACurrentMediaTime();

            CALayer *circle = [CALayer layer];
            circle.frame = CGRectInset(self.bounds, 5.0, 5.0);
            circle.backgroundColor = [[UIColor grayColor] CGColor];
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

            [self.layer addSublayer:circle];
            [circle addAnimation:animGroup forKey:@"spinkit-anim"];
        }
    }
    return self;
}

-(void)applicationWillEnterForeground {
    if (self.stopped) {
        [self pauseLayers];
    } else {
        [self resumeLayers];
    }
}

-(void)applicationDidEnterBackground {
    [self pauseLayers];
}

-(void)startAnimating {
    self.hidden = NO;
    self.stopped = NO;
    [self resumeLayers];
}

-(void)stopAnimating {
    if (self.hidesWhenStopped) {
        self.hidden = YES;
    }

    self.stopped = YES;
    [self pauseLayers];
}

-(void)pauseLayers {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

-(void)resumeLayers {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

-(CGSize)sizeThatFits:(CGSize)size {
    switch (self.style) {
        case RTSpinKitViewStylePlane:
            return CGSizeMake(60.0, 60.0);
            break;

        case RTSpinKitViewStyleBounce:
            return CGSizeMake(60.0, 60.0);
            break;

        case RTSpinKitViewStyleWave:
            return CGSizeMake(50.0, 60.0);
            break;

        case RTSpinKitViewStylePulse:
            return CGSizeMake(60.0, 60.0);
            break;
    }
}

-(void)setColor:(UIColor *)color {
    _color = color;

    for (CALayer *l in self.layer.sublayers) {
        l.backgroundColor = [color CGColor];
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
