//
//  IScene.h
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#ifndef pixel_IScene_h
#define pixel_IScene_h

class IScene
{
public:
    virtual ~IScene() {}
	virtual void Init() = 0;
    virtual void Update(NSTimeInterval timeSinceLastUpdate) = 0;
    virtual void Draw() = 0;
};

#endif
