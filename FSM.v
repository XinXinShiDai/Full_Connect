module FSM(
S_AXIS_ACLK,S_AXIS_ARESETN,Din_Valid,Ti1,Ti2,To1,To2,Cal_Valid,Dout_Valid
    );

    input S_AXIS_ACLK;
    input S_AXIS_ARESETN;
    input Din_Valid,Ti1,Ti2; // 输入序列；
    output reg Cal_Valid,Dout_Valid,To1,To2; // 状态输出；
    
    parameter   S0=2'b00, // Idle and End；
                S1=2'b01, // 有效操作中；；
                S2=2'b11; // 跳变结束；
    
    reg [2:0] cs; // 现态；
    reg [2:0] ns; // 次态；
    /*------------------次态到现态的时序逻辑------------------*/  
    always @(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
        if(!S_AXIS_ARESETN)
            cs <= S0;
        else
            cs <= ns;
    end
    /*------------------现态到次态的组合逻辑------------------*/
    always @(cs or Din_Valid or Ti1 or Ti2) begin
        ns = S0;
        case(cs)
            S0: ns = Din_Valid? S1:S0;
            S1: ns = Ti1? S2:S1;
            S2: ns = Ti2? S0:S2;
       default: ns = S0;
        endcase
     end
     /*------------------现态到输出的组合逻辑------------------*/
     always @(cs) begin
        case(cs)
            S0: begin To1=0;To2=0;Cal_Valid=0;Dout_Valid=0; end
            S1: begin To1=1;To2=0;Cal_Valid=1;Dout_Valid=0; end
            S2: begin To1=0;To2=1;Cal_Valid=0;Dout_Valid=1; end
       default: begin To1=0;To2=0;Cal_Valid=0;Dout_Valid=0; end
        endcase
     end
   
endmodule