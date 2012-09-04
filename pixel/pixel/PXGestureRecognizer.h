//
//  PXGestureRecognizer.h
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//

#import <UIKit/UIKit.h>
#import "SceneManager.h"

@interface PXGestureRecognizer : UIGestureRecognizer<UIAccelerometerDelegate>

- (id)initWithSceneManager:(SceneManager *)sceneManager;

@end
