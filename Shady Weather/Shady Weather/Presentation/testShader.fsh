void main()
{
    vec4 color = vec4(1.0, 0.0, 0.5, 1.0);
   gl_FragColor = vec4(u_color.x, u_time*0.5*v_tex_coord.x-v_tex_coord.y, u_color.z, 1.0);
}
