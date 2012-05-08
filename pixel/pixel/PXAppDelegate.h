//
//  PXAppDelegate.h
//  pixel
//
//  Created by Cédric Raud on 09/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXMainViewController.h"

@class PXViewController;

@interface PXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PXMainViewController *viewController;

@end
