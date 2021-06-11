

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list ipbus_infra/clocks/mmcm_1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 2 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {sca_clocks_locked[0]} {sca_clocks_locked[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[0]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[1]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[2]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[3]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[4]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[5]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[6]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[7]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[8]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[9]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[10]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[11]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[12]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[13]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[14]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[15]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[16]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[17]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[18]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[19]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[20]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[21]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[22]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[23]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[24]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[25]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[26]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[27]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[28]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[29]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[30]} {ipbus_payload/slave2/inst_ipbus_slave_reg_drp/inst_device_fabric/sel[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {ipbus_payload/fabric/ipb_out[ipb_rdata][0]} {ipbus_payload/fabric/ipb_out[ipb_rdata][1]} {ipbus_payload/fabric/ipb_out[ipb_rdata][2]} {ipbus_payload/fabric/ipb_out[ipb_rdata][3]} {ipbus_payload/fabric/ipb_out[ipb_rdata][4]} {ipbus_payload/fabric/ipb_out[ipb_rdata][5]} {ipbus_payload/fabric/ipb_out[ipb_rdata][6]} {ipbus_payload/fabric/ipb_out[ipb_rdata][7]} {ipbus_payload/fabric/ipb_out[ipb_rdata][8]} {ipbus_payload/fabric/ipb_out[ipb_rdata][9]} {ipbus_payload/fabric/ipb_out[ipb_rdata][10]} {ipbus_payload/fabric/ipb_out[ipb_rdata][11]} {ipbus_payload/fabric/ipb_out[ipb_rdata][12]} {ipbus_payload/fabric/ipb_out[ipb_rdata][13]} {ipbus_payload/fabric/ipb_out[ipb_rdata][14]} {ipbus_payload/fabric/ipb_out[ipb_rdata][15]} {ipbus_payload/fabric/ipb_out[ipb_rdata][16]} {ipbus_payload/fabric/ipb_out[ipb_rdata][17]} {ipbus_payload/fabric/ipb_out[ipb_rdata][18]} {ipbus_payload/fabric/ipb_out[ipb_rdata][19]} {ipbus_payload/fabric/ipb_out[ipb_rdata][20]} {ipbus_payload/fabric/ipb_out[ipb_rdata][21]} {ipbus_payload/fabric/ipb_out[ipb_rdata][22]} {ipbus_payload/fabric/ipb_out[ipb_rdata][23]} {ipbus_payload/fabric/ipb_out[ipb_rdata][24]} {ipbus_payload/fabric/ipb_out[ipb_rdata][25]} {ipbus_payload/fabric/ipb_out[ipb_rdata][26]} {ipbus_payload/fabric/ipb_out[ipb_rdata][27]} {ipbus_payload/fabric/ipb_out[ipb_rdata][28]} {ipbus_payload/fabric/ipb_out[ipb_rdata][29]} {ipbus_payload/fabric/ipb_out[ipb_rdata][30]} {ipbus_payload/fabric/ipb_out[ipb_rdata][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 32 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {ipbus_payload/fabric/ipb_in[ipb_wdata][0]} {ipbus_payload/fabric/ipb_in[ipb_wdata][1]} {ipbus_payload/fabric/ipb_in[ipb_wdata][2]} {ipbus_payload/fabric/ipb_in[ipb_wdata][3]} {ipbus_payload/fabric/ipb_in[ipb_wdata][4]} {ipbus_payload/fabric/ipb_in[ipb_wdata][5]} {ipbus_payload/fabric/ipb_in[ipb_wdata][6]} {ipbus_payload/fabric/ipb_in[ipb_wdata][7]} {ipbus_payload/fabric/ipb_in[ipb_wdata][8]} {ipbus_payload/fabric/ipb_in[ipb_wdata][9]} {ipbus_payload/fabric/ipb_in[ipb_wdata][10]} {ipbus_payload/fabric/ipb_in[ipb_wdata][11]} {ipbus_payload/fabric/ipb_in[ipb_wdata][12]} {ipbus_payload/fabric/ipb_in[ipb_wdata][13]} {ipbus_payload/fabric/ipb_in[ipb_wdata][14]} {ipbus_payload/fabric/ipb_in[ipb_wdata][15]} {ipbus_payload/fabric/ipb_in[ipb_wdata][16]} {ipbus_payload/fabric/ipb_in[ipb_wdata][17]} {ipbus_payload/fabric/ipb_in[ipb_wdata][18]} {ipbus_payload/fabric/ipb_in[ipb_wdata][19]} {ipbus_payload/fabric/ipb_in[ipb_wdata][20]} {ipbus_payload/fabric/ipb_in[ipb_wdata][21]} {ipbus_payload/fabric/ipb_in[ipb_wdata][22]} {ipbus_payload/fabric/ipb_in[ipb_wdata][23]} {ipbus_payload/fabric/ipb_in[ipb_wdata][24]} {ipbus_payload/fabric/ipb_in[ipb_wdata][25]} {ipbus_payload/fabric/ipb_in[ipb_wdata][26]} {ipbus_payload/fabric/ipb_in[ipb_wdata][27]} {ipbus_payload/fabric/ipb_in[ipb_wdata][28]} {ipbus_payload/fabric/ipb_in[ipb_wdata][29]} {ipbus_payload/fabric/ipb_in[ipb_wdata][30]} {ipbus_payload/fabric/ipb_in[ipb_wdata][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 3 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {ipbus_payload/fabric/sel[0]} {ipbus_payload/fabric/sel[1]} {ipbus_payload/fabric/sel[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 32 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {ipbus_payload/fabric/ipb_in[ipb_addr][0]} {ipbus_payload/fabric/ipb_in[ipb_addr][1]} {ipbus_payload/fabric/ipb_in[ipb_addr][2]} {ipbus_payload/fabric/ipb_in[ipb_addr][3]} {ipbus_payload/fabric/ipb_in[ipb_addr][4]} {ipbus_payload/fabric/ipb_in[ipb_addr][5]} {ipbus_payload/fabric/ipb_in[ipb_addr][6]} {ipbus_payload/fabric/ipb_in[ipb_addr][7]} {ipbus_payload/fabric/ipb_in[ipb_addr][8]} {ipbus_payload/fabric/ipb_in[ipb_addr][9]} {ipbus_payload/fabric/ipb_in[ipb_addr][10]} {ipbus_payload/fabric/ipb_in[ipb_addr][11]} {ipbus_payload/fabric/ipb_in[ipb_addr][12]} {ipbus_payload/fabric/ipb_in[ipb_addr][13]} {ipbus_payload/fabric/ipb_in[ipb_addr][14]} {ipbus_payload/fabric/ipb_in[ipb_addr][15]} {ipbus_payload/fabric/ipb_in[ipb_addr][16]} {ipbus_payload/fabric/ipb_in[ipb_addr][17]} {ipbus_payload/fabric/ipb_in[ipb_addr][18]} {ipbus_payload/fabric/ipb_in[ipb_addr][19]} {ipbus_payload/fabric/ipb_in[ipb_addr][20]} {ipbus_payload/fabric/ipb_in[ipb_addr][21]} {ipbus_payload/fabric/ipb_in[ipb_addr][22]} {ipbus_payload/fabric/ipb_in[ipb_addr][23]} {ipbus_payload/fabric/ipb_in[ipb_addr][24]} {ipbus_payload/fabric/ipb_in[ipb_addr][25]} {ipbus_payload/fabric/ipb_in[ipb_addr][26]} {ipbus_payload/fabric/ipb_in[ipb_addr][27]} {ipbus_payload/fabric/ipb_in[ipb_addr][28]} {ipbus_payload/fabric/ipb_in[ipb_addr][29]} {ipbus_payload/fabric/ipb_in[ipb_addr][30]} {ipbus_payload/fabric/ipb_in[ipb_addr][31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {ipbus_payload/fabric/ipb_in[ipb_strobe]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {ipbus_payload/fabric/ipb_in[ipb_write]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {ipbus_payload/fabric/ipb_out[ipb_ack]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {ipbus_payload/fabric/ipb_out[ipb_err]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_ipb]
