//
//  RTSpinKitUtils.h
//  SpinKit
//
//  Created by Ramon Torres on 9/5/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTSpinKitView.h"
#import "RTSpinKitAnimating.h"

CATransform3D RTSpinKit3DRotationWithPerspective(CGFloat perspective, CGFloat angle, CGFloat x, CGFloat y, CGFloat z);
NSObject<RTSpinKitAnimating>* RTSpinKitAnimationFromStyle(RTSpinKitViewStyle style);
