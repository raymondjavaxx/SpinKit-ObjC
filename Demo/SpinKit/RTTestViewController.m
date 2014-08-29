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

@end

@implementation RTTestViewController

-(void)insertSpinner:(RTSpinKitView*)spinner
             atIndex:(NSInteger)index
     backgroundColor:(UIColor*)backgroundColor
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = CGRectGetWidth(screenBounds);
    
    UIView *panel = [[UIView alloc] initWithFrame:CGRectOffset(screenBounds, screenWidth * index, 0.0)];
    panel.backgroundColor = backgroundColor;

    spinner.center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    [spinner startAnimating];

    [panel addSubview:spinner];

    UIScrollView *scrollView = (UIScrollView*)self.view;
    [scrollView addSubview:panel];
}

-(void)loadView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.alwaysBounceVertical = NO;
    scrollView.alwaysBounceHorizontal = YES;
    scrollView.backgroundColor = [UIColor darkGrayColor];
    self.view = scrollView;

    [self insertSpinner:[[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePlane color:[UIColor whiteColor]]
                atIndex:0
        backgroundColor:[UIColor colorWithRed:0.827 green:0.329 blue:0 alpha:1.0]];

    [self insertSpinner:[[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleBounce color:[UIColor whiteColor]]
                atIndex:1
        backgroundColor:[UIColor colorWithRed:0.173 green:0.243 blue:0.314 alpha:1.0]];

    [self insertSpinner:[[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWave color:[UIColor whiteColor]]
                atIndex:2
        backgroundColor:[UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1.0]];

    [self insertSpinner:[[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWanderingCubes color:[UIColor whiteColor]]
                atIndex:3
        backgroundColor:[UIColor colorWithRed:0.161 green:0.502 blue:0.725 alpha:1.0]];

    [self insertSpinner:[[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStylePulse color:[UIColor whiteColor]]
                atIndex:4
        backgroundColor:[UIColor colorWithRed:0.498 green:0.549 blue:0.553 alpha:1.0]];

    RTSpinKitView * spinView = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleCircle color:[UIColor whiteColor]];
    spinView.frame = CGRectMake(0, 0, 10, 10);
    [spinView sizeToFit];
    [self insertSpinner:spinView atIndex:5
        backgroundColor:[UIColor colorWithWhite:0.200 alpha:1.000]];

    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    scrollView.contentSize = CGSizeMake(6 * CGRectGetWidth(screenBounds), CGRectGetHeight(screenBounds));
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
