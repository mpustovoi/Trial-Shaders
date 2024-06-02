mat3 GetLightmapTBN(vec3 viewPos) {
    mat3 lightmapTBN = mat3(normalize(dFdx(viewPos)), normalize(dFdy(viewPos)), vec3(0.0));
    lightmapTBN[2] = cross(lightmapTBN[0], lightmapTBN[1]);

    return lightmapTBN;
}