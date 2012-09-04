//
//  PXAppDelegate.h
//  pixel
//
//  Created by Cédric Raud on 09/05/12.
//

#import <UIKit/UIKit.h>
#import "PXMainViewController.h"

@class PXViewController;

@interface PXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PXMainViewController *viewController;

@end
