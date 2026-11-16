varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec3 cor_fundo;
void main() {
    vec4 pixel = texture2D(gm_BaseTexture, v_vTexcoord);
    //SOMENTE OS TRES TONS DO QUADRADO DE FUNDO
    vec3 rgb = pixel.rgb * 255.0;
    bool fundo = all(lessThan(abs(rgb - vec3(238.0, 232.0, 212.0)), vec3(0.5)))
        || all(lessThan(abs(rgb - vec3(255.0, 253.0, 243.0)), vec3(0.5)))
        || all(lessThan(abs(rgb - vec3(179.0, 169.0, 147.0)), vec3(0.5)));
    if (fundo) pixel.rgb *= cor_fundo;
    gl_FragColor = v_vColour * pixel;
}
