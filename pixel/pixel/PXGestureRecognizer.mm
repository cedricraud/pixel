//
//  PXGestureRecognizer.m
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//

#import "PXGestureRecognizer.h"

@interface PXGestureRecognizer () {
    SceneManager* _sceneManager;
}
@end

@implementation PXGestureRecognizer

- (id)initWithSceneManager:(SceneManager *)sceneManager {
    if (self = [super init])
        _sceneManager = sceneManager;
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/30.0];
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    return self;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    IScene* scene = _sceneManager->GetScene();
    if (scene != NULL) scene->DidAccelerate(acceleration);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches)
    {
        //if (touch.tapCount > 0) NSLog(@"Tap: %i", touch.tapCount);
        CGPoint location = [touch locationInView:self.view];
        //NSLog(@"Begin PosX: %f PosY: %f", location.x, location.y);
        IScene* scene = _sceneManager->GetScene();
        if (scene != NULL) scene->TouchBegan(location.x, location.y);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInView:self.view];
        //NSLog(@"Moved PosX: %f PosY: %f", location.x, location.y);
        IScene* scene = _sceneManager->GetScene();
        if (scene != NULL) scene->TouchMoved(location.x, location.y);

    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInView:self.view];
        //NSLog(@"Ended PosX: %f PosY: %f", location.x, location.y);
        IScene* scene = _sceneManager->GetScene();
        if (scene != NULL) scene->TouchEnded(location.x, location.y);

    }
}
@end
