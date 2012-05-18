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
    
    // Path
    _pathPosX = 172;
    _pathTargetPosX = _pathPosX;
    _pathSize = 40;
    _pathLastMove = 0;
    
    // Obstacles
    _speed = 1;
    _nextSpawn = 0;
    
    _atlas = new Atlas(@"atlas.bin");
    
    _numStars = 150;
    _pStars = new bgkStar[_numStars];
    bgkStar* pStar = _pStars;
    for (int i = 0; i < _numStars; i++)
    {
        pStar->x  = rand() % WIDTH - 5;
        pStar->y  = rand() % HEIGHT;
        
        float sp = powf(((rand() % 100) / 100.0), 1.5);
        pStar->sp = sp * 70.0 + 30.0;
        pStar->sc = 0.3 + sp * 0.3;
        pStar->a  = 0.2 + sp * 0.2;
        pStar++;
    }
    
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
    
    // Path
    _pathPosX = _pathPosX * 0.95 + _pathTargetPosX * 0.05;
    if (GetTime() - _pathLastMove > PATH_MOVE_DELAY)
    {
        _pathTargetPosX = 20 + RANDOM * 280;
        _pathLastMove = GetTime() + PATH_MOVE_DELAY;
        //NSLog(@"Path Move: %f", _pathTargetPosX);
    }
    
    // Obstacles
    if (_speed < SPEED_MAX)
        _speed += timeSinceLastUpdate * SPEED_ACC;
    
    while(_obstacles.size() > 0 && _obstacles[0]->IsDead())
        _obstacles.pop_front(); // No pool yet
    
    if (GetTime() > _nextSpawn)
    {
        //NSLog(@"Spawning at Speed: %f", _speed);
        Asteroid* newChallenger = new Asteroid();
        newChallenger->Init(_atlas, _pathPosX, _pathSize);
        _obstacles.push_back(newChallenger);
        
        _nextSpawn = GetTime() + (SPAWN_DELAY_MIN + arc4random() % SPAWN_DELAY_RANDOM) / _speed;
    }

    for (std::deque<IObstacle *>::iterator i = _obstacles.begin(); i != _obstacles.end(); ++i)
        (*i)->Update(timeSinceLastUpdate, _speed + dashSin * 0.75);
    
    
    bgkStar* pStar = _pStars;
    for (int i = 0; i < _numStars; i++)
    {
        
        pStar->y += pStar->sp * timeSinceLastUpdate;
        
        if (pStar->y > HEIGHT)
        {
            pStar->y = 0;
            pStar->x  = rand() % WIDTH - 5;   
        }
        
        pStar++;
    }
}

void QuadDemoScene::Draw()
{
    glClearColor(0.0f, 0.0f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glDisable(GL_DEPTH_TEST);
    
    
    glEnable(GL_BLEND);
    
    glBlendFunc(GL_ONE, GL_ONE);
    
    AtlasCut* starCut = _atlas->getCut("star3");
    
    bgkStar* pStar = _pStars;
    Sprite::SetColor4f(0.3, 0.3, 0.3, 1.0);
    
    for (int i = 0; i < _numStars; i++)
    {
        float a = pStar->a;
        float s = pStar->sc;
        Sprite::SetColor4f(a * 0.7, a * 0.8, a, 1.0);
        Sprite::Draw(pStar->x, pStar->y, starCut->width * s, starCut->height * s,
                     starCut->texX, starCut->texY, starCut->texW, starCut->texH);
        
        pStar++;
    }
    
    
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    
    
    Sprite::SetColor4f(1.0, 1.0, 1.0, 1.0);
    
    // Rocket
    AtlasCut* cut = _atlas->getCut("rocket");
    Sprite::Draw(Vector2D(_posX, _posY), cut->width * 0.5, cut->height * 0.5, (_targetX - _posX) / 60,
                 cut->texX, cut->texY, cut->texW, cut->texH);
    // Path
    cut = _atlas->getCut("coin");
    Sprite::Draw(Vector2D(_pathPosX - _pathSize / 2, 0), _pathSize, 5, 0, cut->texX, cut->texY, cut->texW, cut->texH);
    
    // Obstacles
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
