//
//  Asteroid.h
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//

#ifndef __pixel__Asteroid__
#define __pixel__Asteroid__

#include "IObstacle.h"


class Asteroid : public IObstacle
{
public:
    virtual ~Asteroid();
	virtual void Init(Atlas* atlas, float left, float right);
    virtual void Update(NSTimeInterval timeSinceLastUpdate, float speed);
    virtual void Draw();
    virtual bool IsDead();
    
protected:
    float _posX;
    float _posY;
    float _speedY;
    float _scale;
    float _size;
    float _rotation;
    float _velRotation;
    AtlasCut* _spriteCut;
};

#endif /* defined(__pixel__Asteroid__) */
