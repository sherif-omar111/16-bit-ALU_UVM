/*=================================================================================================
 = File name : ARITHMETIC_UNIT.v                                                                  =
 = Author    : Sherif Omar                                                                        =
 = Linkedin  : https://www.linkedin.com/in/sherif-omar-23829b222/                                 =
 = Email     : sherifomar661@gmail.com  "If you have any questions, feel free to contact me"      =
 = Date      : Mar 03 , 2022                                                                      =
 =================================================================================================*/

module ARITHMETIC_UNIT 

#( parameter IN_DATA_WIDTH = 16,
             OUT_DATA_WIDTH = 16
)

(
input  wire [IN_DATA_WIDTH-1:0]   A   ,
input  wire [IN_DATA_WIDTH-1:0]   B   ,
input  wire [1:0]                 ALU_FUNC ,
input  wire                       CLK ,
input  wire                       Arith_enable ,
output reg                        Carry_OUT,
output reg [OUT_DATA_WIDTH-1:0]   Arith_OUT,
output reg                        Arith_Flag
);

//internal signals
reg [OUT_DATA_WIDTH-1:0]  Arith_OUT_comb  ;
reg                       Arith_Flag_comb ;
wire                      Carry_OUT_comb  ;

//sequential always
always @ (posedge CLK)
 begin 
   Arith_OUT <= Arith_OUT_comb ;
   Carry_OUT <= Carry_OUT_comb ;
   Arith_Flag <= Arith_Flag_comb ;
	end
	

//combinational always	
always @ (*)
 begin 
    Arith_OUT_comb = 1'b0 ;
    Arith_Flag_comb = 1'b0 ;
	if(Arith_enable)
      case (ALU_FUNC)
      2'b00 : begin
              Arith_OUT_comb = A + B ;
              Arith_Flag_comb = 1'b1 ;              
		      end
      2'b01 : begin
              Arith_OUT_comb = A - B ;
              Arith_Flag_comb = 1'b1 ;           
		      end
      2'b10 : begin
              Arith_OUT_comb = A * B ;
              Arith_Flag_comb = 1'b1 ;           
		      end
      2'b11 : begin
              Arith_OUT_comb = A / B ;
              Arith_Flag_comb = 1'b1 ;           
		      end
      endcase
	else
	 begin
      Arith_OUT_comb = 'b0 ;
      Arith_Flag_comb = 1'b0 ;
     end
 end
 
//carry
assign Carry_OUT_comb = Arith_OUT_comb [IN_DATA_WIDTH] ;
 
 endmodule