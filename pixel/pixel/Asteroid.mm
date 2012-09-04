//
//  Asteroid.mm
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//

#include "Asteroid.h"
#include "Sprite.h"

//AtlasCut* Asteroid::_spriteCut = NULL;

void Asteroid::Init(Atlas* pAtlas, float left, float right)
{
    _scale = 1 + RANDOM * 3;
    _size = _scale * 15;
    _posX = _size + left + RANDOM * (right - left - _size);
    //NSLog(@"Between %f and %f I pick %f with size %f", left, right, _posX, _size);
    _posY = -40;
    _speedY = 190 + RANDOM * 20;
    _dead = false;
    _rotation = arc4random() % 5;
    _velRotation = 0.1 + 4 - _scale;
    _spriteCut = pAtlas->getCut("asteroid");
    
    if (RANDOM < 0.03)
    {
        _spriteCut = pAtlas->getCut("bonus");
        _size = 20;
        _rotation = 0;
        _velRotation = 0;
    }
    else if (RANDOM < 0.1)
    {
        _spriteCut = pAtlas->getCut("bricks");
        _size = 20;
        _rotation = 0;
        _velRotation = 0;
    }
}

void Asteroid::Update(NSTimeInterval timeSinceLastUpdate, float speed)
{
    _posY += timeSinceLastUpdate * speed * _speedY;
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