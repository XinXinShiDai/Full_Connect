module FSM(
S_AXIS_ACLK,S_AXIS_ARESETN,Din_Valid,Ti1,Ti2,To1,To2,Cal_Valid,Dout_Valid
    );

    input S_AXIS_ACLK;
    input S_AXIS_ARESETN;
    input Din_Valid,Ti1,Ti2; // �������У�
    output reg Cal_Valid,Dout_Valid,To1,To2; // ״̬�����
    
    parameter   S0=2'b00, // Idle and End��
                S1=2'b01, // ��Ч�����У���
                S2=2'b11; // ���������
    
    reg [2:0] cs; // ��̬��
    reg [2:0] ns; // ��̬��
    /*------------------��̬����̬��ʱ���߼�------------------*/  
    always @(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
        if(!S_AXIS_ARESETN)
            cs <= S0;
        else
            cs <= ns;
    end
    /*------------------��̬����̬������߼�------------------*/
    always @(cs or Din_Valid or Ti1 or Ti2) begin
        ns = S0;
        case(cs)
            S0: ns = Din_Valid? S1:S0;
            S1: ns = Ti1? S2:S1;
            S2: ns = Ti2? S0:S2;
       default: ns = S0;
        endcase
     end
     /*------------------��̬�����������߼�------------------*/
     always @(cs) begin
        case(cs)
            S0: begin To1=0;To2=0;Cal_Valid=0;Dout_Valid=0; end
            S1: begin To1=1;To2=0;Cal_Valid=1;Dout_Valid=0; end
            S2: begin To1=0;To2=1;Cal_Valid=0;Dout_Valid=1; end
       default: begin To1=0;To2=0;Cal_Valid=0;Dout_Valid=0; end
        endcase
     end
   
endmodule