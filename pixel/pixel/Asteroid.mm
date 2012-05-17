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

void Asteroid::Init(Atlas* pAtlas)
{
    _posX = LIMIT_LEFT + RANDOM * (LIMIT_RIGHT - LIMIT_LEFT);
    _posY = -50;
    _velY = 200;
    _scale = 0.7 + RANDOM * 0.6;
    _dead = false;
    _rotation = arc4random() % 5;
    _velRotation = 0.5 + RANDOM * 2.0;
    
    if (!_spriteCut) _spriteCut = pAtlas->getCut("asteroid");
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
    Sprite::Draw(Vector2D(_posX, _posY), _scale * 20, _scale * 20, _rotation,
                 _spriteCut->texX, _spriteCut->texY, _spriteCut->texW, _spriteCut->texH);
}

bool Asteroid::IsDead()
{
    return _dead;
}

Asteroid::~Asteroid()
{
    
}