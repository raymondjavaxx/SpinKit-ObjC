SpinKit-ObjC
============

UIKit port of [SpinKit](https://github.com/tobiasahlin/SpinKit).

Installing
----------

[CocoaPods](http://cocoapods.org/) is the recommended way for adding SpinKit to your project.

    pod 'SpinKit', '~> 1.1'

If you are not yet using CocoaPods, I definetly recommend you to check out their [Getting Started guide](http://guides.cocoapods.org/using/getting-started.html) and the [NSHipster article](http://nshipster.com/cocoapods/).

Usage
-----

Simply instantiate `RTSpinKitView` with the desired style and add to your view hierarchy.

    #import <SpinKit/RTSpinKitView.h>
    ...
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWave];
    [self.view addSubview:spinner];

You can change the size of the spinner by manipulating the `spinnerSize` property. The default size is `37.0`.

    spinner.spinnerSize = 100.0;
    [spinner sizeToFit];

Available styles:

* `RTSpinKitViewStylePlane`
* `RTSpinKitViewStyleCircleFlip`
* `RTSpinKitViewStyleBounce`
* `RTSpinKitViewStyleWave`
* `RTSpinKitViewStyleWanderingCubes`
* `RTSpinKitViewStylePulse`
* `RTSpinKitViewStyleChasingDots`
* `RTSpinKitViewStyleThreeBounce`
* `RTSpinKitViewStyleCircle`
* `RTSpinKitViewStyle9CubeGrid`
* `RTSpinKitViewStyleWordPress`
* `RTSpinKitViewStyleFadingCircle`
* `RTSpinKitViewStyleFadingCircleAlt`
* `RTSpinKitViewStyleArc`
* `RTSpinKitViewStyleArcAlt`

MBProgressHUD
-------------

SpinKit integrates nicely with the amazing [MBProgressHUD](https://github.com/jdg/MBProgressHUD) library:

    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWave color:[UIColor whiteColor]];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.square = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = spinner;
    hud.labelText = NSLocalizedString(@"Loading", @"Loading");

    [spinner startAnimating];

Acknowledgements
----------------

Animations based on [SpinKit](https://github.com/tobiasahlin/SpinKit) by [Tobias Ahlin](https://github.com/tobiasahlin).

[SpinKit Contributors](https://github.com/raymondjavaxx/SpinKit-ObjC/graphs/contributors).
