import subprocess;
import sys;
import glob;
import datetime;
import locale;
import shutil;
import os;
import os.path;
import gen_tcl;
import bin2hex;


check_list = [];

						
						
def check_listup(f_dir):
	global check_list;
	for line in glob.glob(f_dir + '*.bin'):
		line = line.replace(f_dir, "");
		line = line.replace(".bin", "");
		check_list.append(line);



def sim_start(wave_log, top_name, hex_name, tb_model_list, srclist, inclist):
	global check_list;
	cnt = 0;

	#Message
	message = "Check Instructions : ";
	for instlist in check_list:
		message = message + instlist + " ";
	print(message);
	
	#Sim Dir
	if(os.path.exists("sim") != True):
		subprocess.call("mkdir sim", shell=True);
	
	#Simulation Loop
	for line in check_list:
		#Start Time
		date = datetime.datetime.today();
		print("-[" + str(cnt) + "]Start : [" + line + "] : " + date.strftime("%Y-%m-%d %H:%M:%S"));

		#Make TCL File
		gen_tcl.generate_tcl(True, wave_log, tb_model_list, srclist, inclist, "sim/" + line + ".result\n", "sim_run.tcl");

		#Make Simulation HEX file
		fr = open("./bin/" + line + ".bin", "rb");
		read_data = fr.read();
		result_hex = bin2hex.bin2hex(read_data);
		fw = open(hex_name, 'w');
		fw.write(result_hex);
		fr.close();
		fw.close();

		#Start Simlation
		if(wave_log == True):
			subprocess.call('vsim -c -voptargs="+acc" ' + top_name + " -do sim_run.tcl", shell=True);
		else:
			subprocess.call('vsim -c ' + top_name + " -do sim_run.tcl", shell=True);

		#End Time
		date = datetime.datetime.today();
		print("-[" + str(cnt) + "]Finish : [" + line + "] : " + date.strftime("%Y-%m-%d %H:%M:%S"));
		cnt = cnt + 1;

		#Tempfile Remove
		#os.remove(hex_name);
		#os.remove("sim_run.tcl");


#args[1]=code_check.log, srgv[2]=sourcelist.txt args[3]=bin/	
if __name__ == "__main__":
	if(len(sys.argv) != 8):
		print("Error : Parameter Miss");
		sys.exit();

	#Simulation Start
	print("Check Start");
	check_listup(sys.argv[7]);
	if(len(check_list) != 0):
		sim_start((sys.argv[1] == 'True'), sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5], sys.argv[6]);
		print("Simulation Finished");
	else:
		print("Simulation Error.\nNot found simulation binary file.");
