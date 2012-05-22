//
//  IScene.h
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#ifndef pixel_IScene_h
#define pixel_IScene_h

#include <sys/time.h>

class IScene
{
public:
    virtual ~IScene() {}
	virtual void Init() = 0;
    virtual void Update(NSTimeInterval timeSinceLastUpdate) = 0;
    virtual void Draw() = 0;
    virtual void DidAccelerate(UIAcceleration* acceleration) = 0;
    virtual void TouchBegan(double x, double y) = 0;
    virtual void TouchMoved(double x, double y) = 0;
    virtual void TouchEnded(double x, double y) = 0;
    long GetTime()
    {
        struct timeval time;
        gettimeofday(&time, NULL);
        return (time.tv_sec * 1000) + (time.tv_usec / 1000);
    }
};

#endif
