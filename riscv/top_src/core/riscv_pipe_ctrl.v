//-----------------------------------------------------------------
//                         RISC-V Core
//                            V1.0
//                     Ultra-Embedded.com
//                     Copyright 2014-2019
//
//                   admin@ultra-embedded.com
//
//                       License: BSD
//-----------------------------------------------------------------
//
// Copyright (c) 2014-2019, Ultra-Embedded.com
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions 
// are met:
//   - Redistributions of source code must retain the above copyright
//     notice, this list of conditions and the following disclaimer.
//   - Redistributions in binary form must reproduce the above copyright
//     notice, this list of conditions and the following disclaimer 
//     in the documentation and/or other materials provided with the 
//     distribution.
//   - Neither the name of the author nor the names of its contributors 
//     may be used to endorse or promote products derived from this 
//     software without specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE 
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF 
// LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF 
// SUCH DAMAGE.
//-----------------------------------------------------------------
module riscv_pipe_ctrl
//-----------------------------------------------------------------
// Params
//-----------------------------------------------------------------
#(
     parameter SUPPORT_LOAD_BYPASS = 1
    ,parameter SUPPORT_MUL_BYPASS  = 1
    ,parameter SUPPORT_IMAD_BYPASS = 1 
)
//-----------------------------------------------------------------
// Ports
//-----------------------------------------------------------------
(
     input           clk_i
    ,input           rst_i

    ,input [31:0]    fetch_pc_i

    // Issue
    ,input           issue_valid_i
    ,input           issue_accept_i
    ,input           issue_stall_i
    ,input           issue_lsu_i
    ,input           issue_csr_i
    ,input           issue_div_i
    ,input           issue_mul_i
    ,input           issue_imad_i // donghyeon: imad issued
    ,input           issue_branch_i
    ,input           issue_rd_valid_i
    ,input  [4:0]    issue_rd_i
    ,input  [5:0]    issue_exception_i
    ,input           take_interrupt_i
    
    ,input           stall_w_icache_i

    ,input           issue_branch_taken_i
    ,input [31:0]    issue_branch_target_i
    ,input [31:0]    issue_pc_i
    ,input [31:0]    issue_opcode_i         // ?? ? ????? ???. 
    ,input [31:0]    issue_operand_ra_i
    ,input [31:0]    issue_operand_rb_i
    ,input [31:0]    issue_operand_rc_i // donghyeon 

    // Execution stage 1: ALU result
    ,input [31:0]    alu_result_e1_i

    // Execution stage 1: CSR read result / early exceptions
    ,input [ 31:0]   csr_result_value_e1_i
    ,input           csr_result_write_e1_i
    ,input [ 31:0]   csr_result_wdata_e1_i
    ,input [  5:0]   csr_result_exception_e1_i

    // Execution stage 1
    ,output          load_e1_o
    ,output          store_e1_o
    ,output          mul_e1_o
    ,output          imad_e1_o //donghyeon
    ,output          branch_e1_o
    ,output [  4:0]  rd_e1_o
    ,output [31:0]   pc_e1_o
    ,output [31:0]   opcode_e1_o
    ,output [31:0]   operand_ra_e1_o
    ,output [31:0]   operand_rb_e1_o

    // Execution stage 2: Other results
    ,input           mem_complete_i  // donghyeon ? ?? ???? ??? ?? ?? ????. ?? ??? ??? ??? 
    ,input [31:0]    mem_result_e2_i  // nope ???? ?? 
    ,input  [5:0]    mem_exception_e2_i
    ,input [31:0]    mul_result_e2_i

    // Execution stage 2
    ,output          load_e2_o  // ?? E2?? ???? assign ??.  -> scoreboard? ??. 
    ,output          mul_e2_o
    ,output     	    imad_e2_o
    ,output [  4:0]  rd_e2_o
    ,output [31:0]   result_e2_o
    
    //donghyeon: Execution stage3  // much revision still needed 
    ,input           imad_complete_i
    ,input  [31:0]   imad_result_e3_i // ?? reg ? - muladder?? ???. : ??? ?? ??? ?? ?? 
    //,output          imad_e1_o // output? ?? ???? ????. 
    //,output          imad_e2_o
    ,output          imad_e3_o
    ,output  [  4:0] rd_e3_o  //?? reg ?? : ?? ??? decode ?. 

    // Out of pipe: Divide Result
    ,input           div_complete_i
    ,input  [31:0]   div_result_i

    // Commit
    ,output          valid_wb_o
    ,output          csr_wb_o
    ,output [  4:0]  rd_wb_o
    ,output [31:0]   result_wb_o  // WB ??
    ,output [31:0]   pc_wb_o
    ,output [31:0]   opcode_wb_o
    ,output [31:0]   operand_ra_wb_o
    ,output [31:0]   operand_rb_wb_o
    ,output [31:0]   operand_rc_wb_o // donghyeon - checker interface?.. ?? ??. 
    ,output [5:0]    exception_wb_o
    ,output          csr_write_wb_o
    ,output [11:0]   csr_waddr_wb_o
    ,output [31:0]   csr_wdata_wb_o

    ,output          stall_o
    ,output          squash_e1_e2_o
    ,input           squash_e1_e2_i
    ,input           squash_wb_i
);

//-------------------------------------------------------------
// Includes
//-------------------------------------------------------------
`include "riscv_defs.v"

wire squash_e1_e2_w; //e3? ?????. 
wire branch_misaligned_w = (issue_branch_taken_i && issue_branch_target_i[1:0] != 2'b0);

//-------------------------------------------------------------
// E1 / Address
//------------------------------------------------------------- 
`define PCINFO_W     11     //donghyeon should change to 11 
`define PCINFO_ALU       0
`define PCINFO_LOAD      1
`define PCINFO_STORE     2
`define PCINFO_CSR       3
`define PCINFO_DIV       4
`define PCINFO_MUL       5
`define PCINFO_BRANCH    6
`define PCINFO_RD_VALID  7
`define PCINFO_INTR      8
`define PCINFO_COMPLETE  9
`define PCINFO_IMAD      10 // donghyeon: append where?  

`define RD_IDX_R    11:7

reg                     valid_e1_q;
reg [`PCINFO_W-1:0]     ctrl_e1_q;
reg [31:0]              pc_e1_q;
reg [31:0]              npc_e1_q;
reg [31:0]              opcode_e1_q;
reg [31:0]              operand_ra_e1_q;
reg [31:0]              operand_rb_e1_q;
reg [31:0]              operand_rc_e1_q; //donghyeon
reg [`EXCEPTION_W-1:0]  exception_e1_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    valid_e1_q      <= 1'b0;
    ctrl_e1_q       <= `PCINFO_W'b0;
    pc_e1_q         <= 32'b0;
    npc_e1_q        <= 32'b0;
    opcode_e1_q     <= 32'b0;
    operand_ra_e1_q <= 32'b0;
    operand_rb_e1_q <= 32'b0; // rc? ??????; E1->E2->E3 ??? ?? ???. 
    exception_e1_q  <= `EXCEPTION_W'b0;
end
// Stall - no change in E1 state
else if (issue_stall_i)
    ;
else if ((issue_valid_i && issue_accept_i) && ~(squash_e1_e2_o || squash_e1_e2_i)) //valid ?? issue ?? //second cycle of pc 204 
begin
    valid_e1_q                  <= 1'b1;
    ctrl_e1_q[`PCINFO_ALU]      <= ~(issue_lsu_i | issue_csr_i | issue_div_i | issue_mul_i);
    ctrl_e1_q[`PCINFO_LOAD]     <= issue_lsu_i &  issue_rd_valid_i & ~take_interrupt_i; // TODO: Check
    ctrl_e1_q[`PCINFO_STORE]    <= issue_lsu_i & ~issue_rd_valid_i & ~take_interrupt_i;
    ctrl_e1_q[`PCINFO_CSR]      <= issue_csr_i & ~take_interrupt_i;
    ctrl_e1_q[`PCINFO_DIV]      <= issue_div_i & ~take_interrupt_i;
    ctrl_e1_q[`PCINFO_MUL]      <= issue_mul_i & ~take_interrupt_i;
    ctrl_e1_q[`PCINFO_BRANCH]   <= issue_branch_i & ~take_interrupt_i;
    ctrl_e1_q[`PCINFO_RD_VALID] <= issue_rd_valid_i & ~take_interrupt_i;  // ?.. ?? ?? ??? ???. 
    ctrl_e1_q[`PCINFO_INTR]     <= take_interrupt_i;
    ctrl_e1_q[`PCINFO_COMPLETE] <= 1'b1;
    ctrl_e1_q[`PCINFO_IMAD]     <= issue_imad_i;  //donghyeon imad? issue?? ????. // ?? ????? 1 ????. (1st delay) 

    pc_e1_q         <= issue_pc_i;
    npc_e1_q        <= issue_branch_taken_i ? issue_branch_target_i : issue_pc_i + 32'd4;
    opcode_e1_q     <= issue_opcode_i;
    operand_ra_e1_q <= issue_operand_ra_i;
    operand_rb_e1_q <= issue_operand_rb_i;
    operand_rc_e1_q <= issue_operand_rc_i;
    exception_e1_q  <= (|issue_exception_i) ? issue_exception_i : 
                       branch_misaligned_w  ? `EXCEPTION_MISALIGNED_FETCH : `EXCEPTION_W'b0;
end
// No valid instruction (or pipeline flush event)
else
begin
    valid_e1_q      <= 1'b0;
    ctrl_e1_q       <= `PCINFO_W'b0;
    pc_e1_q         <= 32'b0;
    npc_e1_q        <= 32'b0;
    opcode_e1_q     <= 32'b0;
    operand_ra_e1_q <= 32'b0;
    operand_rb_e1_q <= 32'b0;
    exception_e1_q  <= `EXCEPTION_W'b0;
end

wire   alu_e1_w        = ctrl_e1_q[`PCINFO_ALU];
assign load_e1_o       = ctrl_e1_q[`PCINFO_LOAD];
assign store_e1_o      = ctrl_e1_q[`PCINFO_STORE];
wire   csr_e1_w        = ctrl_e1_q[`PCINFO_CSR];
wire   div_e1_w        = ctrl_e1_q[`PCINFO_DIV];
assign mul_e1_o        = ctrl_e1_q[`PCINFO_MUL];
assign branch_e1_o     = ctrl_e1_q[`PCINFO_BRANCH];
assign rd_e1_o         = {5{ctrl_e1_q[`PCINFO_RD_VALID]}} & opcode_e1_q[`RD_IDX_R];
assign pc_e1_o         = pc_e1_q;
assign opcode_e1_o     = opcode_e1_q;
assign operand_ra_e1_o = operand_ra_e1_q;
assign operand_rb_e1_o = operand_rb_e1_q;
assign imad_e1_o =  ctrl_e1_q[`PCINFO_IMAD]; // donghyeon e1 output ?? ??????. 

//-------------------------------------------------------------
// E2 / Mem result
//------------------------------------------------------------- 
reg                     valid_e2_q;
reg [`PCINFO_W-1:0]     ctrl_e2_q;
reg                     csr_wr_e2_q;
reg [31:0]              csr_wdata_e2_q;
reg [31:0]              result_e2_q;
reg [31:0]              pc_e2_q;
reg [31:0]              npc_e2_q;
reg [31:0]              opcode_e2_q;
reg [31:0]              operand_ra_e2_q;
reg [31:0]              operand_rb_e2_q;
reg [`EXCEPTION_W-1:0]  exception_e2_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    valid_e2_q      <= 1'b0;
    ctrl_e2_q       <= `PCINFO_W'b0; // ctrl_e2 ???. 
    csr_wr_e2_q     <= 1'b0;
    csr_wdata_e2_q  <= 32'b0;
    pc_e2_q         <= 32'b0;
    npc_e2_q        <= 32'b0;
    opcode_e2_q     <= 32'b0;
    operand_ra_e2_q <= 32'b0;
    operand_rb_e2_q <= 32'b0;
    result_e2_q     <= 32'b0;
    exception_e2_q  <= `EXCEPTION_W'b0;
end
// Stall - no change in E2 state
else if (issue_stall_i)
    ;
// Pipeline flush
else if (squash_e1_e2_o || squash_e1_e2_i)
begin
    valid_e2_q      <= 1'b0;
    ctrl_e2_q       <= `PCINFO_W'b0;
    csr_wr_e2_q     <= 1'b0;
    csr_wdata_e2_q  <= 32'b0;
    pc_e2_q         <= 32'b0;
    npc_e2_q        <= 32'b0;
    opcode_e2_q     <= 32'b0;
    operand_ra_e2_q <= 32'b0;
    operand_rb_e2_q <= 32'b0;
    result_e2_q     <= 32'b0;
    exception_e2_q  <= `EXCEPTION_W'b0;
end
// Normal pipeline advance
else
begin
    valid_e2_q      <= valid_e1_q;
    ctrl_e2_q       <= ctrl_e1_q;  // ???? ???? 1st cycle delay? ??? ????.  
    csr_wr_e2_q     <= csr_result_write_e1_i;
    csr_wdata_e2_q  <= csr_result_wdata_e1_i;
    pc_e2_q         <= pc_e1_q;
    npc_e2_q        <= npc_e1_q;
    opcode_e2_q     <= opcode_e1_q; // ??? ???!!
    operand_ra_e2_q <= operand_ra_e1_q;
    operand_rb_e2_q <= operand_rb_e1_q;

    // Launch interrupt
    if (ctrl_e1_q[`PCINFO_INTR])
        exception_e2_q  <= `EXCEPTION_INTERRUPT;
    // If frontend reports bad instruction, ignore later CSR errors...
    else if (|exception_e1_q)
    begin
        valid_e2_q      <= 1'b0;
        exception_e2_q  <= exception_e1_q;
    end
    else
        exception_e2_q  <= csr_result_exception_e1_i;

    if (ctrl_e1_q[`PCINFO_DIV])
        result_e2_q <= div_result_i; // ? ?? ??? 1??? ??, ??? ?????? ; MEM stage ??? WB ??? ???? ?. 
    else if (ctrl_e1_q[`PCINFO_CSR])
        result_e2_q <= csr_result_value_e1_i;
    else
        result_e2_q <= alu_result_e1_i;
end

/*
//donghyeon - ctrl_e2_q['PCINFO_IMAD] ??; hopefully delayed by 1 cycle -> ????, ?? ????
always @ (posedge clk_i or posedge rst_i)
  if (ctrl_e1_q[`PCINFO_IMAD])
      ctrl_e2_q[`PCINFO_IMAD] <= 1'b1;
// end of donghyeon
*/
reg [31:0] result_e2_r;

wire valid_e2_w      = valid_e2_q & ~issue_stall_i;

always @ *
begin
    // Default: ALU result
    result_e2_r = result_e2_q;

    if (SUPPORT_LOAD_BYPASS && valid_e2_w && (ctrl_e2_q[`PCINFO_LOAD] || ctrl_e2_q[`PCINFO_STORE]))
        result_e2_r = mem_result_e2_i;
    else if (SUPPORT_MUL_BYPASS && valid_e2_w && ctrl_e2_q[`PCINFO_MUL])
        result_e2_r = mul_result_e2_i;
end

wire   load_store_e2_w = ctrl_e2_q[`PCINFO_LOAD] | ctrl_e2_q[`PCINFO_STORE];
assign load_e2_o       = ctrl_e2_q[`PCINFO_LOAD]; //load ??? ????? (e2??) 
assign mul_e2_o        = ctrl_e2_q[`PCINFO_MUL];
assign rd_e2_o         = {5{(valid_e2_w && ctrl_e2_q[`PCINFO_RD_VALID] && ~stall_o)}} & opcode_e2_q[`RD_IDX_R];
assign result_e2_o     = result_e2_r;
assign imad_e2_o =  ctrl_e2_q[`PCINFO_IMAD]; //donghyeon output e2

// Load store result not ready when reaching E2 // ????? ?? ?? -> rd_wb_o? ? ??? ??? 6? ? ??? ???. 
assign stall_o         = (ctrl_e1_q[`PCINFO_DIV] && ~div_complete_i) || ((ctrl_e2_q[`PCINFO_LOAD] | ctrl_e2_q[`PCINFO_STORE]) & ~mem_complete_i); //||(ctrl_e1_q[`PCINFO_IMAD] && ~imad_complete_i); //donghyeon imad ??

reg [`EXCEPTION_W-1:0] exception_e2_r;
always @ *
begin
    if (valid_e2_q && (ctrl_e2_q[`PCINFO_LOAD] || ctrl_e2_q[`PCINFO_STORE]) && mem_complete_i)
        exception_e2_r = mem_exception_e2_i;
    else
        exception_e2_r = exception_e2_q;
end

assign squash_e1_e2_w = |exception_e2_r;

reg squash_e1_e2_q;

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
    squash_e1_e2_q <= 1'b0;
else if (~issue_stall_i)
    squash_e1_e2_q <= squash_e1_e2_w;

assign squash_e1_e2_o = squash_e1_e2_w | squash_e1_e2_q;

//-------------------------------------------------------------
// darn this thing is reeeeaallly hard  E3 IMAD result. 
//-------------------------------------------------------------
//result ????. //rd_wb_o? ?????. -> div, store ???? ?? delay? ??? ??? ?????. 
//??? ??. e3 ??? ?? ?? ?. ?? e2?? ????. 


//???? reg? ????
//imad? ????? imad? ?????. / ?? ?? instruction? ?? ???, ?? ????. ?? ???? ????. (???? ??, ??) -> ??? ? ?????. 

reg ctrl_imad_e3; // boolean; 1,0 ?? 
reg [31:0]              opcode_e3_q;
always @ (posedge clk_i or posedge rst_i)
  begin // donghyeon ?? 
  opcode_e3_q     <= opcode_e2_q;
  if (rst_i)
      ctrl_imad_e3 <= 1'b0;  // (??? ?? ???? ??) 
  else if (ctrl_e2_q[`PCINFO_IMAD]) //ctrl ????, 
      ctrl_imad_e3 <= 1'b1;
  end
assign imad_e3_o =  ctrl_imad_e3; // ? ????. 
assign rd_e3_o         = {5{ctrl_imad_e3}} & opcode_e3_q[`RD_IDX_R]; // 5*{1/0} & XXXXX : imad rd ??, 2 cycle delay? return. 
// 2) WB ?? 3)? terminate ???? 4) stall  
// e2 ? ??  1) WB ??? ???? ??? ?? ??
// 
//-------------------------------------------------------------
// Writeback / Commit ; ?? ??? IMAD ? ?????. (wb ??: rd_e3_o , ?: pipe_result_wb_w) 
//------------------------------------------------------------- 
reg                     valid_wb_q;
reg [`PCINFO_W-1:0]     ctrl_wb_q;
reg                     csr_wr_wb_q;
reg [31:0]              csr_wdata_wb_q;
reg [31:0]              result_wb_q;
reg [31:0]              pc_wb_q;
reg [31:0]              npc_wb_q;
reg [31:0]              opcode_wb_q;
reg [31:0]              operand_ra_wb_q; //?? ra, rb wb? ? ?? ?????, ?? 
reg [31:0]              operand_rb_wb_q;
reg [`EXCEPTION_W-1:0]  exception_wb_q;
reg [4:0]                   pass_imad_rd_1cycle; //donghyeon

always @ (posedge clk_i or posedge rst_i)
if (rst_i)
begin
    valid_wb_q      <= 1'b0;
    ctrl_wb_q       <= `PCINFO_W'b0;
    csr_wr_wb_q     <= 1'b0;
    csr_wdata_wb_q  <= 32'b0;
    pc_wb_q         <= 32'b0;
    npc_wb_q        <= 32'b0;
    opcode_wb_q     <= 32'b0;
    operand_ra_wb_q <= 32'b0;
    operand_rb_wb_q <= 32'b0;
    result_wb_q     <= 32'b0;
    exception_wb_q  <= `EXCEPTION_W'b0;
end
// Stall - no change in WB state
else if (issue_stall_i)
    ;
else if (squash_wb_i)
begin
    valid_wb_q      <= 1'b0;
    ctrl_wb_q       <= `PCINFO_W'b0;
    csr_wr_wb_q     <= 1'b0;
    csr_wdata_wb_q  <= 32'b0;
    pc_wb_q         <= 32'b0;
    npc_wb_q        <= 32'b0;
    opcode_wb_q     <= 32'b0;
    operand_ra_wb_q <= 32'b0;
    operand_rb_wb_q <= 32'b0;
    result_wb_q     <= 32'b0;
    exception_wb_q  <= `EXCEPTION_W'b0;
end
else
begin
    // Squash instruction valid on memory faults
    case (exception_e2_r)
    `EXCEPTION_MISALIGNED_LOAD,
    `EXCEPTION_FAULT_LOAD,
    `EXCEPTION_MISALIGNED_STORE,
    `EXCEPTION_FAULT_STORE,
    `EXCEPTION_PAGE_FAULT_LOAD,
    `EXCEPTION_PAGE_FAULT_STORE:
        valid_wb_q      <= 1'b0;
    default:
        valid_wb_q      <= valid_e2_q;
    endcase

    csr_wr_wb_q     <= csr_wr_e2_q;  // TODO: Fault disable???
    csr_wdata_wb_q  <= csr_wdata_e2_q;

    // Exception - squash writeback
    if (|exception_e2_r)
        ctrl_wb_q       <= ctrl_e2_q & ~(1 << `PCINFO_RD_VALID);
    else
        ctrl_wb_q       <= ctrl_e2_q;

    pc_wb_q         <= pc_e2_q;
    npc_wb_q        <= npc_e2_q;
    opcode_wb_q     <= opcode_e2_q;
    operand_ra_wb_q <= operand_ra_e2_q;
    operand_rb_wb_q <= operand_rb_e2_q;
    exception_wb_q  <= exception_e2_r;
    
    //if (imad_complete_i && ctrl_e1_q[`PCINFO_IMAD])// && ctrl_e2_q[`PCINFO_IMAD]) //donghyeon ? ? ?? ??.
     //   result_wb_q <= imad_result_e3_i;
    
    if (valid_e2_w && (ctrl_e2_q[`PCINFO_LOAD] || ctrl_e2_q[`PCINFO_STORE]))
        result_wb_q <= mem_result_e2_i;
    else if (valid_e2_w && ctrl_e2_q[`PCINFO_MUL])
        result_wb_q <= mul_result_e2_i;
    
    else if (imad_complete_i && ctrl_e2_q[`PCINFO_IMAD])// && ctrl_e2_q[`PCINFO_IMAD]) //donghyeon ? ? ?? ??. 
        
        result_wb_q <= imad_result_e3_i;
        //pass_imad_rd_1cycle <= pipe_rd_e3_w;
        
    
    else
        result_wb_q <= result_e2_q;
end

// Instruction completion (for debug) // ?? ??? rd_wb_o : wb? ?? / result_wb_o : wb? ?. 
wire complete_wb_w     = ctrl_wb_q[`PCINFO_COMPLETE] & ~issue_stall_i;

assign valid_wb_o      = valid_wb_q & ~issue_stall_i;
assign csr_wb_o        = ctrl_wb_q[`PCINFO_CSR] & ~issue_stall_i; // TODO: Fault disable???
assign rd_wb_o         = {5{(valid_wb_o && ctrl_wb_q[`PCINFO_RD_VALID] && ~stall_o)}} & opcode_wb_q[`RD_IDX_R]; //??? ?? ??. 
assign result_wb_o     = result_wb_q;
assign pc_wb_o         = pc_wb_q;
assign opcode_wb_o     = opcode_wb_q;
assign operand_ra_wb_o = operand_ra_wb_q;
assign operand_rb_wb_o = operand_rb_wb_q;

assign exception_wb_o  = exception_wb_q;

assign csr_write_wb_o  = csr_wr_wb_q;
assign csr_waddr_wb_o  = opcode_wb_q[31:20];
assign csr_wdata_wb_o  = csr_wdata_wb_q;

// Hardware Performance counter signal

wire [31:0] HPC_req_pc;
wire [31:0] HPC_req_next_pc;
wire [31:0] HPC_req_inst_opcode;
wire        HPC_req_inst_valid;

wire        HPC_req_inst_commit;
wire        HPC_req_inst_retired;

wire        HPC_req_inst_ALU;
wire        HPC_req_inst_div;
wire        HPC_req_inst_mul;
wire        HPC_req_inst_imad;
wire        HPC_stall_by_ALU;

wire        HPC_req_inst_load;
wire        HPC_req_inst_store;
wire        HPC_stall_by_MEM;
wire        HPC_stall_by_IMAD;

wire        HPC_req_inst_branch;
wire        HPC_req_branch_taken;
wire [31:0] HPC_req_branch_inst_pc;
wire [31:0] HPC_req_branch_target;
    
assign HPC_req_pc          = issue_pc_i;
assign HPC_req_next_pc     = npc_wb_q;
assign HPC_req_inst_opcode = issue_opcode_i;
assign HPC_req_inst_valid  = issue_valid_i;

assign HPC_req_inst_commit  = issue_valid_i;
//assign HPC_req_inst_retired = valid_e2_w;
assign HPC_req_inst_retired = complete_wb_w;

assign HPC_req_inst_ALU     = issue_valid_i 
                              &&(
                                  (opcode_wb_q[6:0] == 7'b011_0011)
                                ||(opcode_wb_q[6:0] == 7'b001_0011)
                              );
assign HPC_req_inst_div     = issue_valid_i && issue_div_i;
assign HPC_req_inst_mul     = issue_valid_i && issue_mul_i;
assign HPC_req_inst_imad    = issue_valid_i && issue_imad_i; //donghyeon 
assign HPC_stall_by_ALU     = (ctrl_e1_q[`PCINFO_IMAD] && ~imad_complete_i);
assign HPC_stall_by_ALU     = (ctrl_e1_q[`PCINFO_DIV] && ~div_complete_i);

assign HPC_req_inst_load    = load_e1_o;
assign HPC_req_inst_store   = store_e1_o;
assign HPC_stall_by_MEM     = ( ((ctrl_e2_q[`PCINFO_LOAD] | ctrl_e2_q[`PCINFO_STORE]) & ~mem_complete_i) | stall_w_icache_i);

assign HPC_req_inst_branch    = issue_valid_i && issue_branch_i;
assign HPC_req_branch_taken   = issue_branch_taken_i;
assign HPC_req_branch_inst_pc = fetch_pc_i;
assign HPC_req_branch_target  = issue_branch_target_i;

riscv_HPC u_HPC ( // IMAD ?? ???? ???? ??. 
    .clk                (clk_i), 
    .rst_i              (rst_i),

    .req_pc             (HPC_req_pc),
    .req_next_pc        (HPC_req_next_pc),
    .req_inst_opcode    (HPC_req_inst_opcode),
    .req_inst_valid     (HPC_req_inst_valid),

    .req_inst_commit    (HPC_req_inst_commit),
    .req_inst_retired   (HPC_req_inst_retired),

    .req_inst_ALU       (HPC_req_inst_ALU),
    .req_inst_div       (HPC_req_inst_div),
    .req_inst_mul       (HPC_req_inst_mul),
    .stall_by_ALU       (HPC_stall_by_ALU),

    .req_inst_load      (HPC_req_inst_load),
    .req_inst_store     (HPC_req_inst_store),
    .stall_by_MEM       (HPC_stall_by_MEM),

    .req_inst_branch    (HPC_req_inst_branch),
    .req_branch_taken   (HPC_req_branch_taken),
    .req_branch_inst_pc (HPC_req_branch_inst_pc),
    .req_branch_target  (HPC_req_branch_target)
);




endmodule