Shader "Custom/EarthShader" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Cloud ("Base2 (RGB)",2D) = "white" {}
		_Color ("color",Color) = (1,1,1,0.5)
	}
	SubShader {
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		LOD 200
		Pass{
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#include "UnityCG.cginc"

		sampler2D _MainTex;
		sampler2D _Cloud;
		
		float4 _Color;

		struct v2f {
		    float4 pos: SV_POSITION;
			float2 uv: TEXCOORD0;
		};
		float4 _MainTex_ST;
		
		v2f vert (appdata_base v)
		{
		    v2f o;
		    o.pos = mul(UNITY_MATRIX_MVP,v.vertex);
		    o.uv = TRANSFORM_TEX(v.texcoord,_MainTex);
		    return o;
		} 
		half4 frag(v2f i) : COLOR
		{
		    float u_x = i.uv.x + -0.2*_Time;
		    float2 uv_earth = float2(u_x,i.uv.y);
		    half4 texcolor_earth = tex2D (_MainTex,uv_earth);
		    //
		    float2 uv_cloud;
		    u_x = i.uv.x + -0.3*_Time;
		    uv_cloud = float2(u_x,i.uv.y);
		    half4 tex_cloudDepth = tex2D (_Cloud,uv_cloud);
		    //white * depth 
		    half4 texcolor_cloud = float4(1,1,1,0)*(tex_cloudDepth.x);
		    
		    //combine earth with cloud
		    return lerp(texcolor_earth,texcolor_cloud,0.5f);
		
		}
		
		ENDCG
		}
	} 
//	FallBack "Diffuse"
}
