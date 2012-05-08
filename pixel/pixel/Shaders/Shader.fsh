//
//  Shader.fsh
//  pixel
//
//  Created by Cédric Raud on 09/05/12.
//  Copyright (c) 2012 pixel. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
