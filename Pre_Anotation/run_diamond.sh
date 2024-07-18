# blast pep to uniprot_trembl
diamond blastp  --db /data/xuebo/cucumber/database/AHRD/uniprot/uniprot_trembl.dmnd -p 10 --outfmt 6 --more-sensitive --masking 0 -q Total.fa -o tr.txt 
# blast pep to uniprot_sprot
diamond blastp  --db /data/xuebo/cucumber/database/AHRD/uniprot/uniprot_sprot.dmnd -p 10 --outfmt 6 --more-sensitive --masking 0 -q Total.fa -o sp.txt 
# blast pep to araprot10
diamond blastp --db /data/xuebo/cucumber/database/AHRD/TAIR10/araprot10.dmnd -p 10 --outfmt 6 --more-sensitive --masking 0 -q Total.fa -o at.txt 



