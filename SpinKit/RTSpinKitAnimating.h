//
//  RTSpinKitAnimating.h
//  SpinKit
//
//  Created by Ramon Torres on 9/3/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RTSpinKitAnimating <NSObject>
-(void)setupSpinKitAnimationInLayer:(CALayer*)layer withSize:(CGSize)size color:(UIColor*)color;
@end
