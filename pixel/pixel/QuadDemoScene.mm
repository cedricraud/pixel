//
//  QuadDemoScene.mm
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#include "QuadDemoScene.h"

void QuadDemoScene::Init()
{
    Sprite::Init();
}

void QuadDemoScene::Update(NSTimeInterval timeSinceLastUpdate)
{
    _rotation += timeSinceLastUpdate * 0.5f;
}

void QuadDemoScene::Draw()
{
    for (int x = 0; x < 8; x++)
    {
        for (int y = 0; y < 9; y++)
        {
            Sprite::SetColor4f(0.1 + x * 0.1, 0.1 + y * 0.1, 0.5, 1.0);
            float rot = _rotation * (x + y) * 0.25;
            Sprite::Draw(Vector2D(22 + x * 40, 30 + y * 40), 15, 15, rot, 0, 0, 0, 0);
        }
    }
    Sprite::Flush();
}

QuadDemoScene::~QuadDemoScene()
{
    
}
