//
//  SceneManager.mm
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

#include "SceneManager.h"

SceneManager::SceneManager()
{
    _sceneCurrent = 0;
    _sceneCount = 0;
}

int SceneManager::AddScene(IScene* scene)
{
    _scenes[_sceneCount] = scene;
    return _sceneCount++;
}

void SceneManager::SetScene(int index)
{
    _sceneCurrent = index;
    this->GetScene()->Init();
}

IScene* SceneManager::GetScene()
{
    return _scenes[_sceneCurrent];
}