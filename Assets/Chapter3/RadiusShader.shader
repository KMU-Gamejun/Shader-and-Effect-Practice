﻿Shader "Custom/Ch 03/RadiusShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Center("Center", Vector) = (200,0,200,0)
		_Radius("Radius", Float) = 100
		_RadiusColor("Radius Color", Color) = (1,0,0,1)
		_RadiusWidth("Radius Width", Float) = 10
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

        fixed4 _Color;
        sampler2D _MainTex;
		float3 _Center;
		float _Radius;
		float4 _RadiusColor;
		float _RadiusWidth;

        struct Input
        {
            float2 uv_MainTex;
			float3 worldPos;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // 그리려는 곳이 중심과 Input의 월드 좌표 사이의 거리 구하기
			float d = distance(_Center, IN.worldPos);

			if ((d > _Radius) && (d < (_Radius + _RadiusWidth))) {
				o.Albedo = _RadiusColor;
			}
			else {
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			}
        }
        ENDCG
    }
    FallBack "Diffuse"
}
