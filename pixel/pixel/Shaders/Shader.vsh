//
//  Shader.vsh
//  pixel
//
//  Created by Cédric Raud on 09/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

attribute vec4 position;
attribute vec2 tex0;
attribute vec4 color;



varying lowp vec2 texCoords0;
varying lowp vec4 vertexColor;

uniform mat4 modelViewProjectionMatrix;

void main()
{
    texCoords0  = tex0;
    vertexColor = color;
    gl_Position = modelViewProjectionMatrix * position;
}
