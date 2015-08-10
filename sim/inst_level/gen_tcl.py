import subprocess;
import sys;


def generate_tcl(simulate, wave_ena, tb_model_list, srclist, inclist, log_name, save_tcl):
	wr_string = "transcript file " + log_name + "\n";

	#Init & Command
	cmd = "vlog -work work "
	wr_string = wr_string + "vlib work\n";

	#Include
	incdir = "";
	fh = open(inclist, 'r');
	for line in fh:
		incdir = incdir + "+incdir+../" + line.rstrip() + " ";
	fh.close();

	#Make-TB Mode
	fh = open(tb_model_list, 'r');
	for line in fh:
		wr_string = wr_string + cmd + incdir + "" + line + "\n";
	fh.close();

	#Make-Src
	fh = open(srclist, 'r');
	for line in fh:
		wr_string = wr_string + cmd + incdir + "" + line + "\n";
	fh.close();

	if(simulate == True):
		#For Wave save
		if(wave_ena == True):
			wr_string = wr_string + "radix -hexadecimal\n";
			wr_string = wr_string + "log -r /*\n";
		wr_string = wr_string + "run -all\n";

	#Quit
	wr_string = wr_string + "quit\n"

	#Save
	fh = open(save_tcl, "w");
	fh.write(wr_string);
	fh.close();

if __name__ == "__main__":
	if(len(sys.argv) != 7):
		print("Error : Parameter Miss");
		sys.exit();

	generate_tcl(False, (sys.argv[1] == 'True'), sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5], sys.argv[6]);