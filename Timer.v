module Timer(
S_AXIS_ACLK,S_AXIS_ARESETN,Ti1,Ti2,To1,To2
);
	
    input  S_AXIS_ACLK;
    input  S_AXIS_ARESETN;
    input  Ti1,Ti2;
    output To1,To2;
    
    reg [7:0]  cnt1;
    reg [7:0]  cnt2;
    
    // 启动计时模块，共 2 个计数器，计数完成发送信号；
    always @(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
        if(!S_AXIS_ARESETN)
            cnt1 <= 0;
        else begin
            if(Ti1)
                cnt1 <= cnt1 + 1'b1;
            else 
                cnt1 <= 0;
        end
    end
    always @(posedge S_AXIS_ACLK or negedge S_AXIS_ARESETN) begin
        if(!S_AXIS_ARESETN)
            cnt2 <= 0;
        else begin
            if(Ti2)
                cnt2 <= cnt2 + 1'b1;
            else 
                cnt2 <= 0;
        end
    end

    assign To1 = (cnt1 < 8'd63)? 0:1;
    assign To2 = 1;
    
endmodule