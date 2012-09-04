/*
 *  Sprite.h
 *  Sawlog
 *
 *  Created by Sylvain NOWE on 9/5/08.
 *  Copyright 2008 Storybird. All rights reserved.
 *
 */

//#include "GLTexture.h"
#import "Vector2D.h"

#define UV( X ) ( X ) / 1024.0f

class Sprite
{
public:
	static void Draw(float x, float y, float width, float height, float uvx, float uvy, float uvwidth, float uvheight);	
	static void DrawQuad(float x, float y, float width, float height);
	
	static void Draw(Vector2D pos, float radX, float radY, float rot, float uvx, float uvy, float uvwidth, float uvheight);
	static void Draw(float x, float y, float width, float height, float shear, float uvx, float uvy, float uvwidth, float uvheight);

	static void SetColor4f(float r, float g, float b, float a);	
	static void Flush();
	static void Init();
	
	static void SetBlendFunc(GLenum src, GLenum dst);
private:
	
	

	
};

struct vertex_s
{
	float x, y, u, v;
	int   rgba;
};