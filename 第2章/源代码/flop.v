module		flop(data,clock,clear,q,qb);
input		data,clock,clear;
output		q,qb;

nand	#10	 nd1(a,data,clock,clear),
nd2(b,ndata,clock),
nd4(d,c,b,clear),
nd5(e,c,nclock),
nd6(f,d,nclock),
nd8(qb,q,f,clear);

nand	#9	nd3(c,a,d),
nd7(q,e,qb);

not	#10	iv1(ndata,data),
iv2(nclock,clock);

endmodule
