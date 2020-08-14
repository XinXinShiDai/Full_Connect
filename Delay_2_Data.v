module Delay_2_Data(
	input  aclk,
	input  aresetn,
	input  [31:0] iStart,
	output [31:0] oStart
);

reg [31:0] Start_Delay [1:0]; // 数据位宽决定了延时长度；

always @(posedge aclk or negedge aresetn) begin
    if(!aresetn) begin
        Start_Delay[0] <= 0;
        Start_Delay[1] <= 0;
    end
    else begin
        Start_Delay[0] <= iStart;
        Start_Delay[1] <= Start_Delay[0];
    end
end

assign oStart = Start_Delay[1];

endmodule