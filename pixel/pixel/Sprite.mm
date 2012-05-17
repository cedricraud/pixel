/*
 *  Sprite.cpp
 *  Sawlog
 *
 *  Created by Sylvain NOWE on 9/5/08.
 *  Copyright 2008 __MyCompanyName__. All rights reserved.
 *
 */

#import "Sprite.h"
#import <GLKit/GLKit.h>

#define QUAD_BUFFER_SIZE 200

static vertex_s pSpriteGeom[QUAD_BUFFER_SIZE * 4];
static short     pSpriteIndices[QUAD_BUFFER_SIZE * 6];
static int       iBufLen = 0;
static int       iColor = 0;

void Sprite::Init()
{
	short* pBuf = pSpriteIndices;
	
	for (int i = 0; i < QUAD_BUFFER_SIZE; i++)
	{
		(*pBuf++) = i * 4;
		(*pBuf++) = i * 4 + 1;
		(*pBuf++) = i * 4 + 2;
		(*pBuf++) = i * 4 + 1;
		(*pBuf++) = i * 4 + 3;
		(*pBuf++) = i * 4 + 2;
	}
	
	iBufLen = 0;
	iColor  = 0xffffffff;
}

void Sprite::SetBlendFunc(GLenum src, GLenum dst)
{
	Flush();
	glBlendFunc(src, dst);
}

void Sprite::SetColor4f(float r, float g, float b, float a)
{
	int ri = r * 255.0f;
	int gi = g * 255.0f;
	int bi = b * 255.0f;
	int ai = a * 255.0f;
	
	if (ri > 255) ri = 255;
	else if (ri < 0) ri = 0;
	
	if (gi > 255) gi = 255;
	else if (gi < 0) gi = 0;
	
	if (bi > 255) bi = 255;
	else if (bi < 0) bi = 0;
	
	if (ai > 255) ai = 255;
	else if (ai < 0) ai = 0;
	
	iColor = ri | (gi << 8)  | (bi << 16)  | (ai << 24);
}



void Sprite::Draw(float x, float y, float width, float height, float uvx, float uvy, float uvwidth, float uvheight)
{
	if (iBufLen == QUAD_BUFFER_SIZE)
	{
		Flush();
	}

	vertex_s* pVertex = pSpriteGeom + (iBufLen * 4);
	
	pVertex[0].x = x;
	pVertex[0].y = y;
	pVertex[1].x = x + width;
	pVertex[1].y = y;
	pVertex[2].x = x;
	pVertex[2].y = y + height;
	pVertex[3].x = x + width;
	pVertex[3].y = y + height;
	
	pVertex[0].u = uvx;
	pVertex[0].v = uvy;
	pVertex[1].u = uvx + uvwidth;
	pVertex[1].v = uvy;
	pVertex[2].u = uvx;
	pVertex[2].v = uvy + uvheight;
	pVertex[3].u = uvx + uvwidth;
	pVertex[3].v = uvy + uvheight;
	
	pVertex[0].rgba = iColor;
	pVertex[1].rgba = iColor;
	pVertex[2].rgba = iColor;
	pVertex[3].rgba = iColor;
	
	
	iBufLen++;
	
}

void Sprite::Draw(float x, float y, float width, float height, float shear, float uvx, float uvy, float uvwidth, float uvheight)
{
	if (iBufLen == QUAD_BUFFER_SIZE)
	{
		Flush();
	}
	
	vertex_s* pVertex = pSpriteGeom + (iBufLen * 4);
	
	pVertex[0].x = x + shear;
	pVertex[0].y = y;
	pVertex[1].x = x + width + shear;
	pVertex[1].y = y;
	pVertex[2].x = x;
	pVertex[2].y = y + height;
	pVertex[3].x = x + width;
	pVertex[3].y = y + height;
	
	pVertex[0].u = uvx;
	pVertex[0].v = uvy;
	pVertex[1].u = uvx + uvwidth;
	pVertex[1].v = uvy;
	pVertex[2].u = uvx;
	pVertex[2].v = uvy + uvheight;
	pVertex[3].u = uvx + uvwidth;
	pVertex[3].v = uvy + uvheight;
	
	pVertex[0].rgba = iColor;
	pVertex[1].rgba = iColor;
	pVertex[2].rgba = iColor;
	pVertex[3].rgba = iColor;
	
	
	iBufLen++;
}







void Sprite::Draw(Vector2D pos, float radX, float radY, float rot, float uvx, float uvy, float uvwidth, float uvheight)
{
	if (iBufLen == QUAD_BUFFER_SIZE)
	{
		Flush();
	}
	
	float cos_a = cos(rot);
	float sin_a = sin(rot);
	
	float ax =  radX * cos_a;
	float ay =  radX * sin_a;
	
	float bx = -radY * sin_a;
	float by =  radY * cos_a;
	
	vertex_s* pVertex = pSpriteGeom + (iBufLen * 4);

	pVertex[0].x = pos.x - ax - bx;
	pVertex[0].y = pos.y - ay - by;
	pVertex[1].x = pos.x + ax - bx;
	pVertex[1].y = pos.y + ay - by;
	pVertex[2].x = pos.x - ax + bx;
	pVertex[2].y = pos.y - ay + by;
	pVertex[3].x = pos.x + ax + bx;
	pVertex[3].y = pos.y + ay + by;

	
	pVertex[0].u = uvx;
	pVertex[0].v = uvy;
	pVertex[1].u = uvx + uvwidth;
	pVertex[1].v = uvy;
	pVertex[2].u = uvx;
	pVertex[2].v = uvy + uvheight;
	pVertex[3].u = uvx + uvwidth;
	pVertex[3].v = uvy + uvheight;
	
	pVertex[0].rgba = iColor;
	pVertex[1].rgba = iColor;
	pVertex[2].rgba = iColor;
	pVertex[3].rgba = iColor;
	
	iBufLen++;
}



void Sprite::DrawQuad(float x, float y, float width, float height)
{
	Flush();
	    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
	glDisableVertexAttribArray(GLKVertexAttribNormal);
	glEnableVertexAttribArray(GLKVertexAttribColor);
	glDisableVertexAttribArray(GLKVertexAttribTexCoord0);
	glDisable(GL_TEXTURE_2D);

	vertex_s* pVertex = pSpriteGeom;
	
	pVertex[0].x = x;
	pVertex[0].y = y;
	pVertex[1].x = x + width;
	pVertex[1].y = y;
	pVertex[2].x = x;
	pVertex[2].y = y + height;
	pVertex[3].x = x + width;
	pVertex[3].y = y + height;
	
	
	pVertex[0].rgba = iColor;
	pVertex[1].rgba = iColor;
	pVertex[2].rgba = iColor;
	pVertex[3].rgba = iColor;

	glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(vertex_s), pVertex);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_UNSIGNED_BYTE, GL_TRUE, sizeof(vertex_s), (char*)pVertex + 16);
	
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, pSpriteIndices);
	
}

void Sprite::Flush()
{
	if (iBufLen)
	{
        
        glEnableVertexAttribArray(GLKVertexAttribPosition);
        glDisableVertexAttribArray(GLKVertexAttribNormal);
        glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
		glEnableVertexAttribArray(GLKVertexAttribColor);

        //glEnable(GL_TEXTURE_2D);
        
		glDisable(GL_TEXTURE_2D);
		
		glVertexAttribPointer(GLKVertexAttribPosition,  2, GL_FLOAT, GL_FALSE, sizeof(vertex_s), pSpriteGeom);
		glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(vertex_s), (char*)pSpriteGeom + 8);
		glVertexAttribPointer(GLKVertexAttribColor, 4, GL_UNSIGNED_BYTE, GL_TRUE, sizeof(vertex_s), (char*)pSpriteGeom + 16);
		
		glDrawElements(GL_TRIANGLES, iBufLen * 6, GL_UNSIGNED_SHORT, pSpriteIndices);
	}
	
	iBufLen = 0;
}