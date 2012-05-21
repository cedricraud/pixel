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
#define DASH_INPUT_DELAY 500.f
#define DASH_AMPLITUDE 50.f
#define DASH_TIME 400.f
#define SPAWN_DELAY_MIN 50
#define SPAWN_DELAY_RANDOM 150
#define SPEED_ACC 0.06
#define SPEED_MAX 3.f
#define PATH_SIZE 100
#define PATH_MOVE_DELAY 400

enum RocketMode
{
    NORMAL,
    DASH
};


struct bgkStar
{
    float x;
    float y;
    float sp;
    float sc;
    float a;
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
    float _targetY;
    
    
    int         _numStars;
    bgkStar*    _pStars;
    
    std::deque<IObstacle *> _obstacles;
    float _speed;
    float _nextSpawnLeft;
    float _nextSpawnRight;
    
    float _pathPosX;
    float _pathTargetPosX;
    float _pathSize;
    long  _pathLastMove;
    Atlas* _atlas;
    
    virtual void SetMode(RocketMode mode);
};


#endif
