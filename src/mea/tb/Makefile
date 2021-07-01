VSTD=-2008

XILINX_LIB_PATH=/opt/Questasim/10.7c/xilinx_lib_2019.2

FIRMWARE_SRC_DIR=..

SRCS=\
	${FIRMWARE_SRC_DIR}/mea_scan.vhd

TB_DIR=./
TB_NAME=tb_mea_scan
TB_SRCS=\
	${TB_DIR}/${TB_NAME}.vhd


all: sim

comp_logic: 
	vcom -work work ${VSTD} ${SRCS}

comp_tb:
	vcom -work work ${VSTD} ${TB_SRCS}

sim: comp_logic comp_tb
	vsim -fsmdebug -voptargs=+acc -t 1ps work.${TB_NAME} -do add_wave.do

sim_nogui: comp_logic comp_tb
	vsim -voptargs=+acc -t 1ps -c work.${TB_NAME} -do add_wave.do

.PHONY: clean
clean:
	rm -rf work 
realclean:
	rm -rf work transcript _Alert.txt _Log.txt
