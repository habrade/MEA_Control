#!/bin/bash

set -ex

PRJ_NAME=mea-ipbus
TOP_NAME=MEA_Control
IMPL="impl_1"

BUILD_DIR=../build
if [[ ! -d $BUILD_DIR ]]; then
    mkdir $BUILD_DIR
else
    rm -r $BUILD_DIR
    mkdir $BUILD_DIR
fi

BIT_DIR=../${PRJ_NAME}.runs/${IMPL}
BIT=${BIT_DIR}/${TOP_NAME}.bit
LTX=${BIT_DIR}/${TOP_NAME}.ltx

echo "Copy vivado generated .bit file and .ltx file (if they are exist)"
if [[ ! -f ${BIT} ]]; then
    echo ".bit file is not exist, quit!"
    exit 2
else
    cp ${BIT} ${BUILD_DIR}
fi

if [[ ! -f ${LTX} ]]; then
    echo "Warning: .ltx is not exist!"
else
    cp ${LTX} ${BUILD_DIR}
fi

. /opt/Xilinx/Vivado/2020.2/settings64.sh
vivado -nolog -nojournal -mode tcl -source ./gen_mcs.tcl -tclargs "$PRJ_NAME" "$BUILD_DIR" "$BIT"
