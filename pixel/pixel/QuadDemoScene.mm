//
//  QuadDemoScene.mm
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#include "QuadDemoScene.h"
#include "Asteroid.h"

void QuadDemoScene::Init()
{
    Sprite::Init();
    
    // Rocket
    _posX = 172;
    _targetX = _posX;
    _posY = POSY_DEFAULT;
    _mode = NORMAL;
    
    // Obstacles
    _speed = 1;
    _nextSpawn = 0;
    
    _atlas = new Atlas(@"atlas.bin");
    
}

void QuadDemoScene::Update(NSTimeInterval timeSinceLastUpdate)
{
    // Rocket
    _rotation += timeSinceLastUpdate * 0.5f;
    _posX = _posX * 0.4 + _targetX * 0.6;
    if (_posX < 30) _posX = 30;
    if (_posX > WIDTH - 30) _posX = WIDTH - 30;
    
    long time = 0;
    float dashSin = 0;
    switch (_mode) {
        case DASH:
            time = GetTime() - _dashStart;
            dashSin = sin(time / DASH_TIME * M_PI);
            _posY = POSY_DEFAULT - dashSin * DASH_AMPLITUDE;
            if (time > DASH_TIME)
            {
                _posY = POSY_DEFAULT;
                this->SetMode(NORMAL);
            }
            break;
        default:
            break;
    }
    
    // Obstacles
    if (_speed < SPEED_MAX)
        _speed += timeSinceLastUpdate * SPEED_ACC;
    
    while(_obstacles.size() > 0 && _obstacles[0]->IsDead())
        _obstacles.pop_front(); // No pool yet
    
    if (GetTime() > _nextSpawn)
    {
        NSLog(@"Spawning at Speed: %f", _speed);
        Asteroid* newChallenger = new Asteroid();
        newChallenger->Init(_atlas);
        _obstacles.push_back(newChallenger);
        
        _nextSpawn = GetTime() + SPAWN_DELAY_MIN + arc4random() % SPAWN_DELAY_RANDOM;
    }

    for (std::deque<IObstacle *>::iterator i = _obstacles.begin(); i != _obstacles.end(); ++i)
        (*i)->Update(timeSinceLastUpdate, _speed + dashSin * 0.75);
}

void QuadDemoScene::Draw()
{
    glClearColor(0.0f, 0.0f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glDisable(GL_DEPTH_TEST);
    
    glEnable(GL_BLEND);
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    
    
    Sprite::SetColor4f(1.0, 1.0, 1.0, 1.0);
    

    
    AtlasCut* cut = _atlas->getCut("rocket");
    
    //printf("%s %f %f %f %f %f %f\n", cut->name, cut->width, cut->height, cut->texX, cut->texY, cut->texW, cut->texH);
    
    // Rocket
    Sprite::Draw(Vector2D(_posX, _posY), cut->width * 0.5, cut->height * 0.5, (_targetX - _posX) / 60, 
                 cut->texX, cut->texY, cut->texW, cut->texH);
    
    // Obstacles
    /*for (int x = 0; x < 8; x++)
     {
     for (int y = 0; y < 7; y++)
     {            
     float rot = _rotation * (x + y) * 0.25;
     Sprite::Draw(Vector2D(22 + x * 40, 30 + y * 40), 15, 15, rot, x/3.0, y/3.0, 1.0/3.0, 1.0/3.0);
     }
     }*/
    for (std::deque<IObstacle *>::iterator i = _obstacles.begin(); i != _obstacles.end(); ++i)
        (*i)->Draw();
    
    
    Sprite::Flush();
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

void QuadDemoScene::TouchBegan(double x, double y)
{
    if (GetTime() - _lastTouch <= DASH_INPUT_DELAY)
        this->SetMode(DASH);
    
    this->TouchMoved(x, y);
}

void QuadDemoScene::TouchMoved(double x, double y)
{
    _targetX = x;
}

void QuadDemoScene::TouchEnded(double x, double y)
{
    _lastTouch = GetTime();
}

QuadDemoScene::~QuadDemoScene()
{
    
}
