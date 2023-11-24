// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 16
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
   /* input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,*/

    // Logic Analyzer Signals
    /*input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,*/

    // IOs
    input   [1:0]io_in,
    output [3:0] io_out,
    //output [BITS-1:0] io_oeb,

    // IRQ
    //output [2:0] irq
);
    
   



    pes_sipo dut(.clk(wb_clk_i),.b(io_in[0]),.q(io_out[3:0]));

endmodule
`timescale 1ns / 1ps

module pes_sipo(input clk,b,output[3:0]q);

d_ff dut1(.clk(clk),.d(b),.q(q[3]),.rst());
d_ff dut2(.clk(clk),.d(q[3]),.q(q[2]),.rst());
d_ff dut3(.clk(clk),.d(q[2]),.q(q[1]),.rst());
d_ff dut4(.clk(clk),.d(q[1]),.q(q[0]),.rst());

endmodule
// d flip flop

module d_ff (
  input clk,    
  input d,      
  input rst,    
  output reg q);

  always @(posedge clk) 
  begin
    if (rst)
      q <= 1'b0;
    else
      q <= d;
  end

endmodule
`default_nettype wire
