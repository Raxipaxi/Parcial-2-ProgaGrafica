// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DeepWater"
{
	Properties
	{
		_Foam("Foam", Range( 0 , 1)) = 0.01401001
		_Float0("Float 0", Float) = 6
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
		};

		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _Foam;
		uniform float _Float0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth44 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth44 = saturate( abs( ( screenDepth44 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( ( 1.0 - _Foam ) ) ) );
			float4 color5 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 color1 = IsGammaSpace() ? float4(0.2220363,0.7264151,0.640173,0) : float4(0.04039077,0.4865309,0.3674659,0);
			float screenDepth2 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth2 = saturate( abs( ( screenDepth2 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _Float0 ) ) );
			float4 lerpResult17 = lerp( color5 , color1 , ( distanceDepth44 + ( 1.0 - distanceDepth2 ) ));
			o.Albedo = saturate( ( ceil( ( 1.0 - distanceDepth44 ) ) + saturate( lerpResult17 ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17200
0;452;1247;323.6;2568.745;106.0024;1.552448;True;False
Node;AmplifyShaderEditor.CommentaryNode;54;-2042.682,-425.216;Inherit;False;807.571;206.5091;Foam;3;8;44;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1729.594,254.8338;Inherit;False;Property;_Float0;Float 0;1;0;Create;True;0;0;False;0;6;6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2015.957,-342.1707;Inherit;False;Property;_Foam;Foam;0;0;Create;True;0;0;False;0;0.01401001;0.7674716;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;2;-1531.606,236.0954;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;16;-1698.811,-335.0054;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;64;-1248.293,236.535;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;44;-1510.036,-357.7958;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;52;-1067.983,210.3798;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;-1075.979,-256.5936;Inherit;False;287;438.3848;Colores;2;1;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;1;-1025.978,-30.20864;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;False;0;0.2220363,0.7264151,0.640173,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-1023.262,-206.5934;Inherit;False;Constant;_Color1;Color 1;1;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;69;-756.57,201.7863;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;17;-599.9376,-113.8961;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;55;-955.7658,-343.3448;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;68;-379.9551,-112.263;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CeilOpNode;67;-453.7046,-344.9116;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;56;-134.8149,-207.9675;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;18;123.3117,-207.9304;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;334.8409,-212.977;Float;False;True;2;ASEMaterialInspector;0;0;Standard;DeepWater;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;3;0
WireConnection;16;0;8;0
WireConnection;64;0;2;0
WireConnection;44;0;16;0
WireConnection;52;0;44;0
WireConnection;52;1;64;0
WireConnection;69;0;52;0
WireConnection;17;0;5;0
WireConnection;17;1;1;0
WireConnection;17;2;69;0
WireConnection;55;0;44;0
WireConnection;68;0;17;0
WireConnection;67;0;55;0
WireConnection;56;0;67;0
WireConnection;56;1;68;0
WireConnection;18;0;56;0
WireConnection;0;0;18;0
ASEEND*/
//CHKSM=A89D47516E14296DD6FF3A7C3A278E78E467AC71