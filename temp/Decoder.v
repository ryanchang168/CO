//0616088
//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:0616088      Luke
//----------------------------------------------
//Date:        5/19
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------


module Decoder(
    instr_op_i,
    instr_funct_i, 
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	isOri_o,
	BranchType_o,
        Jump_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o,
	ReadDataReg_o,
	isJal_o,
	isJJr_o
);
     
//I/O ports
input  [6-1:0] instr_op_i;
input  [6-1:0] instr_funct_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output		   isOri_o;

output [2-1:0] BranchType_o;
output         Jump_o;
output		   MemRead_o;
output		   MemWrite_o;
output [2-1:0] MemtoReg_o;
output		   ReadDataReg_o;
output         isJal_o;
output [2-1:0] isJJr_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg 		   isOri_o;

reg    [2-1:0] BranchType_o;
reg                Jump_o;
reg   		   MemRead_o;
reg            MemWrite_o;
reg    [2-1:0] MemtoReg_o;
reg  		   ReadDataReg_o;
reg            isJal_o;
reg    [2-1:0] isJJr_o;
//Parameter


//Main function
always @(*)
begin
	isOri_o = 0;
	isJal_o = 0;
	isJJr_o = 2'b00;
	case(instr_op_i)
		// R-type
		6'b000000: begin
			RegDst_o = 1'b1;
			ALUSrc_o = 0;
			RegWrite_o = 1'b1;
			Branch_o = 0;
			BranchType_o = 2'b00; 
                        Jump_o=0;
			MemRead_o = 0;
			MemWrite_o = 0;
			MemtoReg_o = 2'b00; 
			ReadDataReg_o = 1'b1;
			ALU_op_o = 3'b010; 
			if ( instr_funct_i == 6'b001000 ) begin
				
				isJJr_o = 2'b01;
			end
		end
		// addi
		6'b001000: begin
			RegDst_o = 0;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b1;
			Branch_o = 0;
			BranchType_o = 2'b00; 
			Jump_o=0;
			MemRead_o = 0;
			MemWrite_o = 0;
			MemtoReg_o = 2'b00; 
			ReadDataReg_o = 1'b1;
			ALU_op_o = 3'b110;
		end
		// slti
		6'b001010: begin
			RegDst_o = 0;
			ALUSrc_o = 1;
			RegWrite_o = 1;
			Branch_o = 0;
			BranchType_o = 2'b00; 
			Jump_o=0;
			MemRead_o = 0;
			MemWrite_o = 0;
			MemtoReg_o = 2'b00; 
			ReadDataReg_o = 1;
			ALU_op_o = 3'b011;
		end
		// beq
		6'b000100: begin
			RegDst_o = 0; 
			ALUSrc_o = 0;
			RegWrite_o = 0;
			Branch_o = 1;
			BranchType_o = 2'b00;
			Jump_o=0;
			MemRead_o = 0;
			MemWrite_o = 0;
			MemtoReg_o = 2'b00; 
			ReadDataReg_o = 1;
			ALU_op_o = 3'b001;
		end
		// lui
		6'b001111: begin
			RegDst_o = 0;
			ALUSrc_o = 1;
			RegWrite_o = 1;
			Branch_o = 0;
			BranchType_o = 2'b00; 
			Jump_o=0;
			MemRead_o = 0;
			MemWrite_o = 0;
			MemtoReg_o = 2'b00; 
			ReadDataReg_o = 1;
			ALU_op_o = 3'b100;
		end
		// ori
		6'b001101: begin
			RegDst_o = 0;
			ALUSrc_o = 1;
			RegWrite_o = 1;
			Branch_o = 0;
			BranchType_o = 2'b00; 
			Jump_o=0;
			MemRead_o = 0;
			MemWrite_o = 0;
			MemtoReg_o = 2'b00; 
			ReadDataReg_o = 1;
			ALU_op_o = 3'b111;
			isOri_o = 1;
		end
		// bne
		6'b000101: begin
			RegDst_o = 0; 
			ALUSrc_o = 0;
			RegWrite_o = 0;
			Branch_o = 1;
			BranchType_o = 2'b11;
			Jump_o=0;
			MemRead_o = 0;
			MemWrite_o = 0;
			MemtoReg_o = 2'b00; 
			ReadDataReg_o = 1;
			ALU_op_o = 3'b001;
		end
		
		// lw
		6'b100011: begin
			RegDst_o = 0;
			ALUSrc_o = 1;
			RegWrite_o = 1;
			Branch_o = 0;
			BranchType_o = 2'b00; 
			Jump_o=0;
			MemRead_o = 1;
			MemWrite_o = 0;
			MemtoReg_o = 2'b01;
			ReadDataReg_o = 1;
			ALU_op_o = 3'b110;
		end
		// sw
		6'b101011: begin
			RegDst_o = 0;
			ALUSrc_o = 1;
			RegWrite_o = 0;
			Branch_o = 0;
			BranchType_o = 2'b00; 
			Jump_o=0;
			MemRead_o = 0;
			MemWrite_o = 1;
			MemtoReg_o = 2'b00; 
			ReadDataReg_o = 1;
			ALU_op_o = 3'b110;
		end
		// jump
		6'b000010: begin
			RegDst_o = 0; 
			ALUSrc_o = 0; 
			RegWrite_o = 0; 
			Branch_o = 0; 
			BranchType_o = 2'b00; 
			Jump_o=1;
			MemRead_o = 0;
			MemWrite_o = 0; 
			MemtoReg_o = 2'b00; 
			ReadDataReg_o = 1; 
			ALU_op_o = 3'b010; 
			isJJr_o = 2'b10;
		end
		// jal
		6'b000011: begin
			RegDst_o = 0; 
			ALUSrc_o = 0;
			RegWrite_o = 1;
			Branch_o = 0; 
			BranchType_o = 2'b00; 
			Jump_o=1;
			MemRead_o = 0; 
			MemWrite_o = 0; 
			MemtoReg_o = 2'b11;
			ReadDataReg_o = 1; 
			ALU_op_o = 3'b010;
			isJal_o = 1;
			isJJr_o = 2'b10;
		end

			endcase

end

endmodule    
                    