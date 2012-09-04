//
//  Shader.fsh
//  pixel
//
//  Created by Cédric Raud on 09/05/12.
//

varying lowp vec2 texCoords0;
varying lowp vec4 vertexColor;

uniform sampler2D texture;

void main()
{
    gl_FragColor = texture2D(texture, texCoords0) * vertexColor;
}
