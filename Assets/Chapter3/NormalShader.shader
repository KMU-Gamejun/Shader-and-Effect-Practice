Shader "Custom/Ch 03/NormalShader"
{
    Properties
    {
        _MainTint("Diffuse Tint", color) = (0, 1, 0, 1)
		_NormalTex("Normal Map", 2D) = "bumb" {}
		_NormalMapIntensity("Normal Intensity", Range(0, 3)) = 1
	}
		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _NormalTex;
		float4 _MainTint;
		float _NormalMapIntensity;

        struct Input
        {
            float2 uv_NormalTex;
        };



        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			// 머티리얼의 기본 색상으로 제공되는 색조 사용
			o.Albedo = _MainTint;

			// UnpackNormal 함수를 사용해 노멀 맵 텍스처에서 법선 데이터를 가져온다
			float3 normalMap = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex));

			normalMap.x *= _NormalMapIntensity;
			normalMap.y *= _NormalMapIntensity;

			// 새로운 법선을 라이팅 모델에 적용한다
			o.Normal = normalMap.rgb;
			//o.Normal = normalize(normalMap.rgb);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
