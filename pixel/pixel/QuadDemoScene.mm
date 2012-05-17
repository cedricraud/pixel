//
//  QuadDemoScene.mm
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#include "QuadDemoScene.h"

void QuadDemoScene::Init()
{
    Sprite::Init();
    
    _posX = 172;
    _posY = POSY_DEFAULT;
    _mode = NORMAL;
}

void QuadDemoScene::Update(NSTimeInterval timeSinceLastUpdate)
{
    _rotation += timeSinceLastUpdate * 0.5f;
    _posX = _posX * 0.3 + _targetX * 0.7;
    if (_posX < 30) _posX = 30;
    if (_posX > WIDTH - 30) _posX = WIDTH - 30;
    
    long time;
    switch (_mode) {
        case DASH:
            time = GetTime() - _dashStart;
            _posY = POSY_DEFAULT - sin(time / DASH_TIME * M_PI) * DASH_AMPLITUDE;
            if (time > DASH_TIME)
            {
                _posY = POSY_DEFAULT;
                this->SetMode(NORMAL);
            }
            break;
        default:
            break;
    }
}

void QuadDemoScene::SetMode(RocketMode mode)
{
    switch (mode) {
        case NORMAL:
            NSLog(@"MODE: NORMAL");
            break;
        case DASH:
            if (_mode == DASH) return;
            NSLog(@"MODE: DASH");
            _mode = DASH;
            _dashStart = GetTime();
            break;
    }
    _mode = mode;
}

void QuadDemoScene::Draw()
{
    Sprite::SetColor4f(1.0, 1.0, 1.0, 1.0);
    
    for (int x = 0; x < 8; x++)
    {
        for (int y = 0; y < 7; y++)
        {
            //Sprite::SetColor4f(0.1 + x * 0.1, 0.1 + y * 0.1, 0.5, 1.0);
            
            float rot = _rotation * (x + y) * 0.25;
            Sprite::Draw(Vector2D(22 + x * 40, 30 + y * 40), 15, 15, rot, x/3.0, y/3.0, 1.0/3.0, 1.0/3.0);
        }
    }
    
    Sprite::Draw(Vector2D(_posX, _posY), 15, 25, 0, 0, 0, 1, 1);
    Sprite::Flush();
}

void QuadDemoScene::TouchBegan(double x, double y)
{
    if (GetTime() - _lastMove <= DASH_INPUT_DELAY)
        this->SetMode(DASH);
    
    this->TouchMoved(x, y);
}

void QuadDemoScene::TouchMoved(double x, double y)
{
    _targetX = x;
    _lastMove = GetTime();
}

void QuadDemoScene::TouchEnded(double x, double y)
{
    
}

QuadDemoScene::~QuadDemoScene()
{
    
}
