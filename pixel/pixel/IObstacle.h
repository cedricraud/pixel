//
//  IObstacle.h
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//

#ifndef pixel_IObstacle_h
#define pixel_IObstacle_h

#include "Atlas.h"

#define DEAD 520

class IObstacle
{

    
public:
    virtual ~IObstacle() {}
	virtual void Init(Atlas* atlas, float left, float right) = 0;
    virtual void Update(NSTimeInterval timeSinceLastUpdate, float speed) = 0;
    virtual void Draw() = 0;
    virtual bool IsDead() = 0;

protected:
    bool _dead;
};


#endif
