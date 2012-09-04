//
//  SceneManager.h
//  pixel
//
//  Created by Cédric Raud on 17/05/12.
//

#ifndef pixel_SceneManager_h
#define pixel_SceneManager_h

#include "IScene.h"

class SceneManager
{
public:
    SceneManager();
    int AddScene(IScene* scene);
    void SetScene(int index);
    IScene* GetScene();
    
protected:
    IScene* _scenes[10];
    int _sceneCurrent;
    int _sceneCount;
    
};

#endif
