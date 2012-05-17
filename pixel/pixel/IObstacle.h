//
//  IObstacle.h
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#ifndef pixel_IObstacle_h
#define pixel_IObstacle_h

#include "Atlas.h"

#define LIMIT_LEFT 20
#define LIMIT_RIGHT 280
#define LIMIT_BOTTOM 520

class IObstacle
{

    
public:
    virtual ~IObstacle() {}
	virtual void Init(Atlas*) = 0;
    virtual void Update(NSTimeInterval timeSinceLastUpdate, float speed) = 0;
    virtual void Draw() = 0;
    virtual bool IsDead() = 0;

protected:
    bool _dead;
};


#endif
