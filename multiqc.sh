#install multiqc
sudo apt -get update
sudo apt install multiqc

#run multiqc on all the files in the same directory where the fastqc ooutput files are saved
multiqc * -interactive #runs multiqc on all the diles and a constraint is added interactive to make the output generatd more interactive
