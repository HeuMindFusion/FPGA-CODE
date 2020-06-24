`timescale 1ns / 1ps


module dec1(
    input clk,
	 input rst,
	 //input z2_en,
	 input[29:0] z2_1,             //�⽻֯��1���������Ϣ
	 input[29:0] z2_2,
	 input[29:0] z2_3,
	 input[29:0] z2_4,
	 input[15:0] x_1,              //ϵͳ��Ԫ
	 input[15:0] x_2,
	 input[15:0] x_3,
	 input[15:0] x_4,
	 input[15:0] y1_1,             //У��λ1��Ԫ
	 input[15:0] y1_2,
	 input[15:0] y1_3,
	 input[15:0] y1_4,
	 output[29:0] w1_1,             //��֯��1����������Ϣ
	 output[29:0] w1_2,
	 output[29:0] w1_3,
	 output[29:0] w1_4,
	 output[30:0] softout11,
	 output[30:0] softout12,
	 output[30:0] softout13,
	 output[30:0] softout14
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
//wire[30:0] softout1;
//wire[30:0] softout2;
//wire[30:0] softout3;
//wire[30:0] softout4;
wire path_start;
wire soft_start;

control       con(.clk(clk),                 //����ģ�飬�������ƣ�����Ϣ�����������Ϣ���룬ŷʽ�������
                  .rst(rst),
						//.z2_en(z2_en),
						.z21(z2_1),
						.z22(z2_2),
						.z23(z2_3),
						.z24(z2_4),
						.x1(x_1),
						.x2(x_2),
						.x3(x_3),
						.x4(x_4),
						.y1_1(y1_1),
						.y1_2(y1_2),
						.y1_3(y1_3),
						.y1_4(y1_4),
						.soft_out1(softout11),
						.soft_out2(softout12),
						.soft_out3(softout13),
						.soft_out4(softout14),
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
						.w1_1(w1_1),
						.w1_2(w1_2),
						.w1_3(w1_3),
						.w1_4(w1_4),
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
						
survive        sur(.clk(clk),               //������֧��ŷʽ�������
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
						 
path           pat(.clk(clk),               //�Ҵ�·���ļ��㣬������
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
						 
soft_out        so(.clk(clk),               //����Ϣ
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
						 .soft_out1(softout11),
						 .soft_out2(softout12),
						 .soft_out3(softout13),
						 .soft_out4(softout14)
						 );

endmodule
