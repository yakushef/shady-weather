void main()
{
    float transition = u_transition;
    float speed = u_wind*u_time;
    vec4 color = mix(new_color, old_color, transition);
    
    vec2 uv = -1. + 2. * v_tex_coord;
    gl_FragColor = vec4(
        abs(sin(cos(speed+3.*uv.y)*2.*uv.x+speed)),
        abs(cos(sin(speed+2.*uv.x)*3.*uv.y+speed)),
        color.z,
        1.0);
}
