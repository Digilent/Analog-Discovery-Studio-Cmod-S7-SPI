# This is an automatically generated file used by digilent_vivado_checkout.tcl to set project options
proc set_project_properties_post_create_project {proj_name} {
    set project_obj [get_projects $proj_name]
	set_property "part" "xc7s25csga225-1" $project_obj
	set_property "board_part" "digilentinc.com:cmod-s7-25:part0:1.0" $project_obj
	set_property "default_lib" "xil_defaultlib" $project_obj
	set_property "simulator_language" "Mixed" $project_obj
	set_property "target_language" "Verilog" $project_obj
}

proc set_project_properties_pre_add_repo {proj_name} {
    set project_obj [get_projects $proj_name]
    # default nothing
}

proc set_project_properties_post_create_runs {proj_name} {
    set project_obj [get_projects $proj_name]
	set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
    # default nothing
}
