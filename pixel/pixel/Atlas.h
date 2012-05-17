//
//  Atlas.h
//  pixel
//
//  Created by Philippe Desgranges on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#ifndef pixel_Atlas_h
#define pixel_Atlas_h

#include "Texture2D.h"



struct AtlasCut
{
    char name[32];
    float width;
    float height;
    float texX;
    float texY;
    float texW;
    float texH;
};

class Atlas
{
    int         numCuts;
    AtlasCut*   cuts;
public:
    Atlas(NSString* pAtlasName/*, Texture2D* pTex*/);
    ~Atlas();
    
    AtlasCut*  getCut(const char* id);
};

#endif
