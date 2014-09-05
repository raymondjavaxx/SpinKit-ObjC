//
//  RTSpinKitView.h
//  SpinKit
//
//  Created by Ramon Torres on 1/1/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RTSpinKitViewStyle) {
    RTSpinKitViewStylePlane,
    RTSpinKitViewStyleCircleFlip,
    RTSpinKitViewStyleBounce,
    RTSpinKitViewStyleWave,
    RTSpinKitViewStyleWanderingCubes,
    RTSpinKitViewStylePulse,
    RTSpinKitViewStyleChasingDots,
    RTSpinKitViewStyleThreeBounce,
    RTSpinKitViewStyleCircle,
    RTSpinKitViewStyle9CubeGrid,
    RTSpinKitViewStyleWordPress,
    RTSpinKitViewStyleFadingCircle,
    RTSpinKitViewStyleFadingCircleAlt
};

@interface RTSpinKitView : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL hidesWhenStopped;
@property (nonatomic, assign) RTSpinKitViewStyle style;
@property (nonatomic, assign, getter = isStopped) BOOL stopped;

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style;
-(instancetype)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor*)color;
-(instancetype)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor*)color spinnerSize:(CGFloat)spinnerSize;

-(void)startAnimating;
-(void)stopAnimating;
-(BOOL)isAnimating;

@end
