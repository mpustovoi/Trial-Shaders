//Settings//
#include "/lib/settings.glsl"

//Fragment Shader//
#ifdef FSH

//Varyings//
varying vec2 texCoord;

varying vec4 color;
uniform float time;
//Uniforms//
uniform ivec2 eyeBrightnessSmooth;

uniform sampler2D texture;

//Common Variables//
float eBS = eyeBrightnessSmooth.y / 240.0;

//Program//
void main() {
    // Sample the texture and multiply it by the base color
    vec4 albedo = texture2D(texture, texCoord) * color;

    // Calculate the glint effect based on some property, e.g., specular reflection
    float glintIntensity = .05; // Adjust this value to control the intensity of the glint
    vec3 glintEffect = vec3(glintIntensity);

    // Apply the glint effect by adding it to the original color
    // Note: This is a simple additive blend. You might want to use a more sophisticated method
    albedo.rgb += glintEffect * albedo.rgb;

    // Output the final color with the glint effect
    gl_FragData[0] = albedo;
}

#endif

//Vertex Shader//
#ifdef VSH

//Varyings//
varying vec2 texCoord;

varying vec4 color;

//Uniforms//
#ifdef TAA
uniform int frameCounter;

uniform float viewWidth;
uniform float viewHeight;
#include "/lib/util/jitter.glsl"
#endif

//Includes//

//Program//
void main() {
	texCoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;

	color = gl_Color;

	gl_Position = ftransform();
}

#endif