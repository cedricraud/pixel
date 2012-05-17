//
//  QuadDemoScene.h
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#ifndef pixel_QuadDemoScene_h
#define pixel_QuadDemoScene_h

#include "IScene.h"
#include "Sprite.h"

class QuadDemoScene : public IScene
{
public:
    virtual ~QuadDemoScene();
    virtual void Init();
    virtual void Update(NSTimeInterval timeSinceLastUpdate);
    virtual void Draw();

protected:
    float _rotation;

};

#endif
