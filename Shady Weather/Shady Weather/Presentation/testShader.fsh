void main()
{
    vec2 uv = -1. + 2. * v_tex_coord;
    gl_FragColor = vec4(
        abs(sin(cos(u_time+3.*uv.y)*2.*uv.x+u_time)),
        abs(cos(sin(u_time+2.*uv.x)*3.*uv.y+u_time)),
                        u_color.z,
        1.0);
}
