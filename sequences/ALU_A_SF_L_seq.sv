/*=================================================================================================
 = File name : ALU_A_SF_L_seq.sv                                                                  =
 = Author    : Sherif Omar                                                                        =
 = Linkedin  : https://www.linkedin.com/in/sherif-omar-23829b222/                                 =
 = Email     : sherifomar661@gmail.com  "If you have any questions, feel free to contact me"      =
 = Date      : Sep 07 , 2022                                                                      =
 =================================================================================================*/

`ifndef ALU_A_SF_L_SEQ
`define ALU_A_SF_L_SEQ
class ALU_A_SF_L_seq extends ALU_seq;
  `uvm_object_utils(ALU_A_SF_L_seq)

  function new(string name="ALU_A_SF_L_seq");
    super.new(name);
  endfunction : new

  virtual function bit get_trans(ALU_trans trans);
    return (trans.randomize() with {
      opcode_m == ADD;
    });
  endfunction : get_trans

  virtual task body;
    super.body();
  endtask : body
endclass : ALU_A_SF_L_seq
`endif