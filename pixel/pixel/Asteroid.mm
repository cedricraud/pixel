//
//  Asteroid.mm
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#include "Asteroid.h"
#include "Sprite.h"

void Asteroid::Init(float pathPosX, float pathSize)
{
    _scale = 1 + RANDOM * 0.3;
    _size =_scale * 15;
    do {
            _posX = LIMIT_LEFT + RANDOM * (LIMIT_RIGHT - LIMIT_LEFT);
    } while (abs(_posX - pathPosX) < pathSize / 2 + _size / 2);
    _posY = -50;
    _velY = 200;
    _dead = false;
    _rotation = arc4random() % 5;
    _velRotation = 1 + RANDOM * 0.5;
}

void Asteroid::Update(NSTimeInterval timeSinceLastUpdate, float speed)
{
    _posY += timeSinceLastUpdate * speed * _velY;
    _rotation += timeSinceLastUpdate * _velRotation;
    
    if (_posY > LIMIT_BOTTOM)
        _dead = true;
}

void Asteroid::Draw()
{
    Sprite::Draw(Vector2D(_posX, _posY), _size, _size, _rotation, 0, 0, 1, 1);
}

bool Asteroid::IsDead()
{
    return _dead;
}

Asteroid::~Asteroid()
{
    
}