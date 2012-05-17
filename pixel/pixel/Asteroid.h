//
//  Asteroid.h
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#ifndef __pixel__Asteroid__
#define __pixel__Asteroid__

#include "IObstacle.h"


  class Asteroid : public IObstacle
{
    static AtlasCut* _spriteCut;
    
public:
    virtual ~Asteroid();
	virtual void Init(Atlas*);
    virtual void Update(NSTimeInterval timeSinceLastUpdate, float speed);
    virtual void Draw();
    virtual bool IsDead();
    
protected:
    float _posX;
    float _posY;
    float _velY;
    float _scale;
    float _rotation;
    float _velRotation;
};

#endif /* defined(__pixel__Asteroid__) */
