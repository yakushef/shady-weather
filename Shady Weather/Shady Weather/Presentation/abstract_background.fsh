#define S(a,b,t) smoothstep(a,b,t)

void main()
{
    
    mat2 Rot(float a)
    {
        float s = sin(a);
        float c = cos(a);
        return mat2(c, -s, s, c);
    }

    vec2 hash( vec2 p )
    {
        p = vec2( dot(p,vec2(2127.1,81.17)), dot(p,vec2(1269.5,283.37)) );
        return fract(sin(p)*43758.5453);
    }

    float noise( in vec2 p )
    {
        vec2 i = floor( p );
        vec2 f = fract( p );
        
        vec2 u = f*f*(3.0-2.0*f);

        float n = mix( mix( dot( -1.0+2.0*hash( i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                            dot( -1.0+2.0*hash( i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                       mix( dot( -1.0+2.0*hash( i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                            dot( -1.0+2.0*hash( i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
        return 0.5 + 0.5*n;
    }
    
    
    
    
    vec2 res = vec2(500.0,500.0);
    vec2 uv = v_tex_coord/res;
    float ratio = 1.0;

    vec2 tuv = uv;
    tuv -= .5;

    // rotate with Noise
    float degree = noise(vec2(u_time*.1, tuv.x*tuv.y));

    tuv.y *= 1./ratio;
    tuv *= Rot(radians((degree-.5)*720.+180.));
    tuv.y *= ratio;

    
    // Wave warp with sin
    float frequency = 5.;
    float amplitude = 30.;
    float speed = u_time * 4.;
    tuv.x += sin(tuv.y*frequency+speed)/amplitude;
    tuv.y += sin(tuv.x*frequency*1.5+speed)/(amplitude*.5);
    
    
    // draw the image
    vec3 colorYellow = vec3(.957, .804, .623);
    vec3 colorDeepBlue = vec3(.192, .384, .933);
    vec3 layer1 = mix(colorYellow, colorDeepBlue, S(-.3, .2, (tuv*Rot(radians(-1.))).x));
    
    vec3 colorRed = vec3(.910, .510, .8);
    vec3 colorBlue = vec3(0.350, .71, .953);
    vec3 layer2 = mix(colorRed, colorBlue, S(-.3, .2, (tuv*Rot(radians(-1.))).x));
    
    vec3 finalComp = mix(layer1, layer2, S(.5, -.3, tuv.y));
    
    vec3 col = finalComp;
    
    gl_FragColor = vec4(col,1.0);
}

