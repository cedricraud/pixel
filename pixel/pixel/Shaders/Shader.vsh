//
//  Shader.vsh
//  pixel
//
//  Created by Cédric Raud on 09/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

attribute vec4 position;
attribute vec4 color;

varying lowp vec4 vertexColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main()
{

/*
    vec3 eyeNormal = normalize(normalMatrix * normal);
    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    vec4 diffuseColor = vec4(0.4, 0.4, 1.0, 1.0);
    
    float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
*/
    
    vertexColor = color;
    gl_Position = modelViewProjectionMatrix * position;
}
