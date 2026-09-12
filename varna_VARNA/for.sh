#!/bash/bin

for file in $(ls -ltr frame.* | awk '{split($9,a,"."); print a[2]}' );
do

mkdir f_$file #2 > /dev/null
cd f_$file 

#x3dna-dssr -i=../frame.$file -o=$file.out	

java -cp /mnt/rna/home/nkumarachchi2019/SCRIPTS/varana_vienna_2drna_images/VARNAv3-93-src.jar fr.orsay.lri.varna.applications.VARNAcmd -i dssr-2ndstrs.bpseq -o img.jpeg

cd ../

convert -delay 1 -loop 0 f_[1-3]/img.jpeg myimage.gif

#java -cp /mnt/rna/home/nkumarachchi2019/SCRIPTS/varana_vienna_2drna_images/VARNAv3-93-src.jar fr.orsay.lri.varna.applications.VARNAcmd -i dssr-2ndstrs.bpseq -o out.jpeg

#convert -delay 1 -loop 0 $(printf "f_%d/img.jpeg " {1..10}) -append combined.jpg

done


