SpinKit-ObjC
============

UIKit port of [SpinKit](https://github.com/tobiasahlin/SpinKit).

Usage
-----

Simply instantiate `RTSpinKitView` with the desired style and add to your view hierarchy.

    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleWave];
    [self.view addSubview:spinner];

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
* `RTSpinKitViewStyleFadingCircleAl`

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
