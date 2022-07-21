#!/bin/sh

RED="\033[0;31m"
YEL="\033[0;33m"
GRN="\033[0;32m"
BLU="\033[0;96m"
BLD="\033[0;1m"
NC="\033[0;0;39m"

function red(){
	echo -e ${RED}$@${NC}
}
function yel(){
	echo -e ${YEL}$@${NC}
}
function grn(){
	echo -e ${GRN}$@${NC}
}
function blu(){
	echo -e ${BLU}$@${NC}
}
function bld(){
	echo -e ${BLD}$@${NC}
}
