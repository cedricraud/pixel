//
//  QuadDemoScene.h
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#ifndef pixel_QuadDemoScene_h
#define pixel_QuadDemoScene_h

#include "IScene.h"
#include "Sprite.h"

#define WIDTH 320
#define HEIGHT 480
#define POSY_DEFAULT 410
#define DASH_INPUT_DELAY 500.f
#define DASH_AMPLITUDE 100.f
#define DASH_TIME 400.f

enum RocketMode
{
    NORMAL,
    DASH
};

class QuadDemoScene : public IScene
{
public:
    virtual ~QuadDemoScene();
    virtual void Init();
    virtual void Update(NSTimeInterval timeSinceLastUpdate);
    virtual void Draw();
    virtual void TouchBegan(double x, double y);
    virtual void TouchMoved(double x, double y);
    virtual void TouchEnded(double x, double y);

protected:
    RocketMode _mode;
    long _dashStart;
    long _lastMove;
    float _rotation;
    float _posX;
    float _posY;
    float _targetX;
    
    virtual void SetMode(RocketMode mode);
};


#endif
