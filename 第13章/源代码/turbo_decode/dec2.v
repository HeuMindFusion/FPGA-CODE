`timescale 1ns / 1ps


module dec2(
   input clk,
	input rst,
	//input z1_en,
	input[29:0] z1_1,
	input[29:0] z1_2,
	input[29:0] z1_3,
	input[29:0] z1_4,
	input[15:0] y2_1,
	input[15:0] y2_2,
	input[15:0] y2_3,
	input[15:0] y2_4,
	input[15:0] x_i1,
	input[15:0] x_i2,
	input[15:0] x_i3,
	input[15:0] x_i4,
	output[29:0] w2_1,
	output[29:0] w2_2,
	output[29:0] w2_3,
	output[29:0] w2_4,
	output[30:0] softout1,
	output[30:0] softout2,
	output[30:0] softout3,
	output[30:0] softout4
    );
wire[29:0] v1n;
wire[29:0] v2n;
wire[29:0] v3n;
wire[29:0] v4n;
wire[29:0] v5n;
wire[29:0] v6n;
wire[29:0] v7n;
wire[29:0] v8n;
wire[29:0] v9n;
wire[29:0] v10n;
wire[29:0] v11n;
wire[29:0] v12n;
wire[29:0] v13n;
wire[29:0] v14n;
wire[29:0] v1o;
wire[29:0] v2o;
wire[29:0] v3o;
wire[29:0] v4o;
wire[29:0] v5o;
wire[29:0] v6o;
wire[29:0] v7o;
wire[29:0] v8o;
wire[29:0] v9o;
wire[29:0] v10o;
wire[29:0] v11o;
wire[29:0] v12o;
wire[29:0] v13o;
wire[29:0] v14o;
wire[15:0] m11m;
wire[15:0] m21m;
wire[15:0] m31m;
wire[15:0] m41m;
wire[15:0] m12m;
wire[15:0] m22m;
wire[15:0] m32m;
wire[15:0] m42m;
wire[3:0] csurvive;
wire path_start;
wire soft_start;
//wire[30:0] softout1;
//wire[30:0] softout2;
//wire[30:0] softout3;
//wire[30:0] softout4;

control2     con2(.clk(clk),                 //控制模块，迭代控制，外信息输出，先验信息输入，欧式距离更新
                  .rst(rst),
						//.z1_en(z1_en),
						.z11(z1_1),
						.z12(z1_2),
						.z13(z1_3),
						.z14(z1_4),
						.x1(x_i1),
						.x2(x_i2),
						.x3(x_i3),
						.x4(x_i4),
						.y2_1(y2_1),
						.y2_2(y2_2),
						.y2_3(y2_3),
						.y2_4(y2_4),
						.soft_out1(softout1),
						.soft_out2(softout2),
						.soft_out3(softout3),
						.soft_out4(softout4),
						.v_1(v1o),
						.v_2(v2o),
						.v_3(v3o),
						.v_4(v4o),
						.v_5(v5o),
						.v_6(v6o),
						.v_7(v7o),
						.v_8(v8o),
						.v_9(v9o),
						.v_10(v10o),
						.v_11(v11o),
						.v_12(v12o),
						.v_13(v13o),
						.v_14(v14o),
						.w2_1(w2_1),
						.w2_2(w2_2),
						.w2_3(w2_3),
						.w2_4(w2_4),
						.v1_n(v1n),
						.v2_n(v2n),
						.v3_n(v3n),
						.v4_n(v4n),
						.v5_n(v5n),
						.v6_n(v6n),
						.v7_n(v7n),
						.v8_n(v8n),
						.v9_n(v9n),
						.v10_n(v10n),
						.v11_n(v11n),
						.v12_n(v12n),
						.v13_n(v13n),
						.v14_n(v14n),
						.m1_1(m11m),
						.m2_1(m21m),
						.m3_1(m31m),
						.m4_1(m41m),
						.m1_2(m12m),
						.m2_2(m22m),
						.m3_2(m32m),
						.m4_2(m42m)
						);

survive2      sur2(.clk(clk),               //各个分支的欧式距离计算
                   .rst(rst),
						 .m11(m11m),
						 .m21(m21m),
						 .m31(m31m),
						 .m41(m41m),
						 .m12(m12m),
						 .m22(m22m),
						 .m32(m32m),
						 .m42(m42m),
						 .v_1(v1o),
						 .v_2(v2o),
						 .v_3(v3o),
						 .v_4(v4o),
						 .v_5(v5o),
						 .v_6(v6o),
						 .v_7(v7o),
						 .v_8(v8o),
						 .v_9(v9o),
						 .v_10(v10o),
						 .v_11(v11o),
						 .v_12(v12o),
						 .v_13(v13o),
						 .v_14(v14o),
						 .sur_end(path_start)
						 );

path2         pat2(.clk(clk),               //幸存路径的计算，译码结果
                   .rst(path_start),
						 .v_1(v1n),
						 .v_2(v2n),
						 .v_3(v3n),
						 .v_4(v4n),
						 .v_5(v5n),
						 .v_6(v6n),
						 .v_7(v7n),
						 .v_8(v8n),
						 .v_9(v9n),
						 .v_10(v10n),
						 .v_11(v11n),
						 .v_12(v12n),
						 .v_13(v13n),
						 .v_14(v14n),
						 //.path_survive(path_survive),
						 .c_survive(csurvive),
						 .path_end(soft_start)
						 );

softout     so1(.clk(clk),
                .rst(soft_start),
					 .c_survive(csurvive),
					 .v_1(v1n),
					 .v_2(v2n),
					 .v_3(v3n),
					 .v_4(v4n),
					 .v_5(v5n),
					 .v_6(v6n),
					 .v_7(v7n),
					 .v_8(v8n),
					 .v_9(v9n),
					 .v_10(v10n),
					 .v_11(v11n),
					 .v_12(v12n),
					 .v_13(v13n),
					 .v_14(v14n),
					 .soft_out1(softout1),
					 .soft_out2(softout2),
					 .soft_out3(softout3),
					 .soft_out4(softout4)
					 );


endmodule
