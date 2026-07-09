.PHONY : install_cal install_flight do_nothing

do_nothing :
	echo "Specify 'make install_flight' or 'make install_cal'"

install_cal :
	ssh POPS_BBB.cfg.cal pops:/media/uSD/POPS_BBB.cfg

install_flight :
	ssh POPS_BBB.cfg pops:/media/uSD/POPS_BBB.cfg
