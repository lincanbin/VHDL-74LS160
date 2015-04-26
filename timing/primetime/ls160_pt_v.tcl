set report_default_significant_digits 3
set hierarchy_separator .
set quartus_root "c:/quartus90sp2portable/app/quartus/altera/90sp2/quartus/"
set search_path [list . [format "%s%s" $quartus_root "eda/synopsys/primetime/lib"]  ]
set link_path [list *  flex10ke_asynch_io_lib.db  flex10ke_lcell_register_lib.db  flex10ke_asynch_lcell_lib.db  flex10ke_asynch_mem_lib.db  flex10ke_pll_lib.db  alt_vtl.db]
read_verilog  flex10ke_all_pt.v 
read_verilog  ls160.vo
current_design ls160
link
regexp {([1-9][0-9][0-9][0-9]\.[0-9][0-9])} $sh_product_version dummy version
if { [string compare "2004.06" $version ] != -1 } {
   set timing_propagate_single_condition_min_slew false
}
set_operating_conditions -analysis_type single
read_sdf ls160_v.sdo
create_clock -period 100.000 -waveform {0.000 50.000} [get_ports { clk } ] -name clk  
set_propagated_clock [all_clocks]
update_timing