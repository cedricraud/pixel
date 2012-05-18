//
//  Asteroid.mm
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#include "Asteroid.h"
#include "Sprite.h"

AtlasCut* Asteroid::_spriteCut = NULL;

void Asteroid::Init(Atlas* pAtlas, float left, float right)
{
    _scale = 0.5 + RANDOM * 0.8;
    _size = _scale * 15;
    _posX = _size + left + RANDOM * (right - left - _size);
    //NSLog(@"Between %f and %f I pick %f with size %f", left, right, _posX, _size);
    _posY = -30;
    _velY = 190 + RANDOM * 20;
    _dead = false;
    _rotation = arc4random() % 5;
    _velRotation = 0.5 + RANDOM * 2.0;
    _spriteCut = pAtlas->getCut("asteroid");
}

void Asteroid::Update(NSTimeInterval timeSinceLastUpdate, float speed)
{
    _posY += timeSinceLastUpdate * speed * _velY;
    _rotation += timeSinceLastUpdate * _velRotation;
    
    if (_posY > DEAD)
        _dead = true;
}

void Asteroid::Draw()
{
    Sprite::Draw(Vector2D(_posX, _posY), _size, _size, _rotation,
                 _spriteCut->texX, _spriteCut->texY, _spriteCut->texW, _spriteCut->texH);
}

bool Asteroid::IsDead()
{
    return _dead;
}

Asteroid::~Asteroid()
{
    
}