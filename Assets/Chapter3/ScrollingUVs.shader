﻿Shader "Custom/Ch 03/ScrollingUVs"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_ScrollXSpeed ("X Scroll Speed", Range(0, 10)) = 2
		_ScrollYSpeed("Y Scroll Speed", Range(0, 10)) = 2
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
		fixed _ScrollXSpeed;
		fixed _ScrollYSpeed;

        struct Input
        {
            float2 uv_MainTex;
        };


        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			// tex2D() 함수로 전달하기전
			// UV 저장을 위한 별도의 변수 생성
			fixed2 scrolledUV = IN.uv_MainTex;

			// 시간에 따른 UV의 조절을 위한
			// x와 y 컴포넌트 각각을 저장하는 변수 생성
			fixed xScrollValue = _ScrollXSpeed * _Time;
			fixed yScrollValue = _ScrollYSpeed * _Time;

			// 최종 UV 오프셋 적용
			scrolledUV += fixed2(xScrollValue, yScrollValue);

			// 텍스처 및 색조 적용
			half4 c = tex2D(_MainTex, scrolledUV);
			o.Albedo = c.rgb * _Color;
			o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
