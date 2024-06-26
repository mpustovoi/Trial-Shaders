vec4 SimpleReflection(vec3 viewPos, vec3 normal, float dither, out float reflectionMask) {
    vec4 color = vec4(0.0);
	float border = 0.0;
	reflectionMask = 0.0;

    vec4 pos = Raytrace(depthtex1, viewPos, normal, dither, border, 4, 1.0, 0.1, 2.0);
	border = clamp(13.333 * (1.0 - border), 0.0, 1.0);

	float zThreshold = 1.0 - 1e-5;
	
	if (pos.z < zThreshold) {
		#if MC_VERSION > 10800
		color = texture2D(gaux2, pos.st);
		#else
		color = texture2DLod(gaux2, pos.st, 0);
		#endif
		reflectionMask = color.a;

		color.a *= border;
		reflectionMask *= border;
	}
	
    return color;
}