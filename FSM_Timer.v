module FSM_Timer(
S_AXIS_ACLK,S_AXIS_ARESETN,Din_Valid,Cal_Valid,Dout_Valid,Addr
    );
    input  S_AXIS_ACLK;
    input  S_AXIS_ARESETN;
    input  Din_Valid;
    output Cal_Valid;
    output Dout_Valid;
    output [5:0] Addr;
    wire Ti1,Ti2,To1,To2;
    FSM FSM(
    .S_AXIS_ACLK(S_AXIS_ACLK),
    .S_AXIS_ARESETN(S_AXIS_ARESETN),
    .Din_Valid(Din_Valid),
    .Ti1(Ti1),.Ti2(Ti2),.To1(To1),.To2(To2),
    .Cal_Valid(Cal_Valid),
    .Dout_Valid(Dout_Valid)
    );
    Timer Timer(
    .S_AXIS_ACLK(S_AXIS_ACLK),
    .S_AXIS_ARESETN(S_AXIS_ARESETN),
   .Ti1(To1),.Ti2(To2),.To1(Ti1),.To2(Ti2),
   .Addr(Addr)
   );
endmodule