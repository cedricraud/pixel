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
#include "IObstacle.h"
#include <deque>
#include "Atlas.h"

#define WIDTH 320
#define HEIGHT 480
#define POSY_DEFAULT 410
#define DASH_INPUT_DELAY 200.f
#define DASH_AMPLITUDE 100.f
#define DASH_TIME 400.f
#define SPAWN_DELAY_MIN 150
#define SPAWN_DELAY_RANDOM 300
#define SPEED_ACC 0.040
#define SPEED_MAX 4.f

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
    long _lastTouch;
    float _rotation;
    float _posX;
    float _posY;
    float _targetX;
    
    std::deque<IObstacle *> _obstacles;
    float _speed;
    float _nextSpawn;
    
    Atlas* _atlas;
    
    virtual void SetMode(RocketMode mode);
};


#endif
