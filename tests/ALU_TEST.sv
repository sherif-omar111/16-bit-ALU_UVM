/*=================================================================================================
 = File name : ALU_TEST.sv                                                                        =
 = Author    : Sherif Omar                                                                        =
 = Linkedin  : https://www.linkedin.com/in/sherif-omar-23829b222/                                 =
 = Email     : sherifomar661@gmail.com  "If you have any questions, feel free to contact me"      =
 = Date      : Sep 03 , 2022                                                                      =
 =================================================================================================*/

`ifndef ALU_TEST
`define ALU_TEST

class ALU_TEST extends uvm_test ;
    `uvm_component_utils(ALU_TEST)

    ALU_env         ALU_env_a;
    ALU_seq         alu_seq_m;
    alu_seq_cfg     alu_seq_cfg_m;
    alu_ral         alu_ral_m;
    bit             phase_ended_m;

function new(string name , uvm_component_parent);
    super.new(name, parent) ;
endfunction : new 

//build phase
virtual function void build_phase(uvm_phase phase) ;
    super.build_phase(phase);
    ALU_ENV_a       = ALU_ENV::type_id::create("ALU_ENV_a",this);
    alu_seq_m       = alu_seq::type_id::create("alu_seq_m");
    alu_seq_cfg_m   = alu_seq_cfg::type_id::create("alu_seq_cfg_m");
    alu_ral_m       = alu_ral::type_id::create("alu_ral_m");
    alu_seq_cfg_m.randomize();
    alu_ral_m.build();
    alu_ral_m.randomize();
    uvm_config_db#(alu_seq_cfg)::set(this,"alu_env_m", "alu_seq_cfg",alu_seq_cfg_m);
    uvm_config_db#(alu_ral::set(this,"alu_env_m", "alu_ral",alu_ral_m);
endfunction : build_phase

//connect phase
virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
endfunction : connect_phase

//configure phase
virtual task configure_phase(uvm_phase phase);
    uvm_status_e status;
    phase.raise_objection(this);
    alu_ral_m.update(status);
    phase.drop_objection(this);
endtask : configure_phase

//main phase
virtual task main_phase(uvm_phase phase);
    phase.raise_objection(this);
    alu_seq_m.start(alu_env_m.alu_agent_m.seqr_m);
    phase.drop_objection(this);
endtask : main_phase

virtual function void phase_ready_to_end(uvm_phase phase);
    const int unsigned watchdog = 20;
    super.phase_ready_to_end(phase);
    if(phase.is(uvm_run_phase::get())) begin
      if(!phase_ended_m) begin
        phase.raise_objection(this);
        fork begin
          repeat(watchdog) begin
            #1ns;
          end
          phase_ended_m = 1;
          phase.drop_objection(this);
        end
        join_none
      end
    end
  endfunction : phase_ready_to_end

endclass : alu_test

`endif

