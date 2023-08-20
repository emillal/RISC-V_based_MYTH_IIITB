
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;
   $val1[31:0] = $reset ? 1 : (>>1$out[31:0]);
   $val2[31:0] = $rand2[3:0];
   $op[1:0] = $rand3[1:0];
   
   $sum[31:0] = $val1[31:0] + $val2[31:0];
   $diff[31:0] = $val1[31:0] - $val2[31:0];
   $prod[31:0] = $val1[31:0] * $val2[31:0];
   $quot[31:0] = $val1[31:0] / $val2[31:0];
   
   $out[31:0] = ($op[1:0]==2'b00) ? $sum[31:0] : 
                                    ($op[1:0]==2'b01) ? $diff[31:0] :
                                                       ($op[1:0]==2'b10) ? $prod[31:0] : 
                                                                           $quot[31:0];
  
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule

