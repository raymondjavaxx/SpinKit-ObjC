//
//  RTTestViewController.m
//  SpinKit
//
//  Created by Ramon Torres on 1/1/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTTestViewController.h"
#import "RTSpinKitView.h"

@interface RTTestViewController ()
@property (nonatomic, assign) NSInteger numberOfSpinners;
@end

@implementation RTTestViewController

-(void)loadView {
    self.numberOfSpinners = 0;

    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.alwaysBounceVertical = NO;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.directionalLockEnabled = YES;
    scrollView.backgroundColor = [UIColor darkGrayColor];
    self.view = scrollView;

    [self insertSpinnerOfStyle: RTSpinKitViewStylePlane
               backgroundColor:[UIColor colorWithRed:0.827 green:0.329 blue:0 alpha:1.0]
                         label:@"Plane"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyleBounce
               backgroundColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1.0]
                         label:@"Bounce"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyleWave
               backgroundColor:[UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1.0]
                         label:@"Wave"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyleWanderingCubes
               backgroundColor:[UIColor colorWithRed:0.161 green:0.502 blue:0.725 alpha:1.0]
                         label:@"WanderingCubes"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStylePulse
               backgroundColor:[UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1.0]
                         label:@"Pulse"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyleCircleFlip
               backgroundColor:[UIColor colorWithWhite:0.200 alpha:1.000]
                         label:@"CircleFlip"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyleChasingDots
               backgroundColor:[UIColor colorWithRed:0.95 green:0.77 blue:0.06 alpha:1.0]
                         label:@"ChasingDots"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyleThreeBounce
               backgroundColor:[UIColor colorWithRed:0.83 green:0.33 blue:0.0 alpha:1.0]
                         label:@"ThreeBounce"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyleCircle
               backgroundColor:[UIColor colorWithRed:0.15 green:0.68 blue:0.38 alpha:1.0]
                         label:@"Circle"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyle9CubeGrid
               backgroundColor:[UIColor colorWithRed:0.68 green:0.15 blue:0.47 alpha:1.0]
                         label:@"9CubeGrid"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyleWordPress
               backgroundColor:[UIColor colorWithRed:0.08 green:0.57 blue:0.86 alpha:1.0]
                         label:@"WordPress"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyleFadingCircle
               backgroundColor:[UIColor colorWithRed:0.0 green:0.60 blue:0.24 alpha:1.0]
                         label:@"FadingCircle"];
    
    [self insertSpinnerOfStyle: RTSpinKitViewStyleFadingCircleAlt
               backgroundColor:[UIColor colorWithRed:0.60 green:0.0 blue:0.0 alpha:1.0]
                         label:@"FadingCircleAlt"];

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    scrollView.contentSize = CGSizeMake(self.numberOfSpinners * CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds));
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)insertSpinnerOfStyle:(RTSpinKitViewStyle)style
            backgroundColor:(UIColor*)backgroundColor
                      label:(NSString *)labelString
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:style color:[UIColor whiteColor]];
    
    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    [spinner startAnimating];
    
    UIView *panel = [[UIView alloc] initWithFrame:CGRectOffset(screenBounds, screenWidth * self.numberOfSpinners, 0.0)];
    panel.backgroundColor = backgroundColor;
    [panel addSubview:spinner];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50.0, screenWidth, 30.0)];
    label.text = labelString;
    label.font = [UIFont systemFontOfSize:25.0];
    label.textColor = [UIColor whiteColor];
    
    if ([label respondsToSelector:@selector(tintColor)]) {
        label.textAlignment = NSTextAlignmentCenter;
    } else {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        label.textAlignment = UITextAlignmentCenter;
#pragma GCC diagnostic pop
        label.backgroundColor = [UIColor clearColor];
    }
    
    [panel addSubview:label];
    
    UIScrollView *scrollView = (UIScrollView*)self.view;
    [scrollView addSubview:panel];
    
    self.numberOfSpinners += 1;
}

@end
