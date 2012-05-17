//
//  Atlas.cpp
//  pixel
//
//  Created by Philippe Desgranges on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#include "Atlas.h"

Atlas::Atlas(NSString* pAtlasName/*, Texture2D* pTex*/)
{
	NSString *path = [[NSBundle mainBundle] pathForResource:pAtlasName ofType:nil];
	
	FILE *file = fopen([path UTF8String], "r");
    
    fseek(file, 0L, SEEK_END);
    int sz = ftell(file);
    fseek(file, 0L, SEEK_SET);
    
    
    numCuts = sz / sizeof(AtlasCut);
    
    cuts = new AtlasCut[numCuts];
    
	fread(cuts, sizeof(AtlasCut), numCuts, file);
    
	fclose(file);
    
    NSLog(@"[Atlas] Here are the available cuts:");
    for (int i = 0; i < numCuts; i++)
    {
        NSLog(@"- %s", cuts[i].name);
    }
}

AtlasCut*  Atlas::getCut(const char* id)
{
    for (int i = 0; i < numCuts; i++)
    {
        if (strncmp(id, cuts[i].name, 32) == 0)
        {
            return &cuts[i];
        }
    }
    
    return NULL;
}


Atlas::~Atlas()
{
    delete[] cuts;
}
