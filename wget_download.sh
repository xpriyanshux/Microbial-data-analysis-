mkdir project1
cd project1
vi wget_script
#!/bin/bash // hashbang line 
	wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/run/ERR1XX/ERRXXXXX/XXXXX.BLANK.1.1F.fastq.gz
 .
 .
 .
 .
 .
 #all such ftp download links generated by ENA
chmod +x wget_script #to change the accessibility permission to become an executable file
./wget_script
#this will then downolad all the samples whose ftp link is provided int he .sh fles
