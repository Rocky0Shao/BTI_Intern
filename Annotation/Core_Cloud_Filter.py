import csv
import pandas as pd
from Bio import SeqIO

gene_num_path = r"C:\Users\Fei Lab\Desktop\Intern_Git\BTI_Intern\Annotation\I_d.tsv"
search_path = r"C:\Users\Fei Lab\Desktop\Intern_Git\BTI_Intern\Annotation\Total.fa"
target_core_path = r"C:\Users\Fei Lab\Desktop\Intern_Git\BTI_Intern\Annotation\Core_Genes.fa"
target_cloud_path = r"C:\Users\Fei Lab\Desktop\Intern_Git\BTI_Intern\Annotation\Cloud_Genes.fa"
df = pd.read_csv(gene_num_path, sep='\t',header=1)

gen_num_col = df[df.columns[1]]

orthogroup_core_names = []
orthogroup_cloud_names = []

while len(orthogroup_core_names) < 30:
    for i in range(df.shape[0]):
        if (gen_num_col.iloc[i] == 39):
            orthogroup_core_names.append(df.iloc[i,0])

while len(orthogroup_cloud_names) < 30:
    for i in range(df.shape[0]):
        if (gen_num_col.iloc[i] == 1):
            orthogroup_cloud_names.append(df.iloc[i,0]) 


fasta_dict = {}

# Read the FASTA file and populate the dictionary
for record in SeqIO.parse(search_path, "fasta"):
    fasta_dict[record.id] = str(record.seq)

core_dic = {}
cloud_dic = {}

for i in orthogroup_core_names:
    core_dic[i] = fasta_dict[i]

for i in orthogroup_cloud_names:
    cloud_dic[i] = fasta_dict[i]

def write_dict_to_fasta(fasta_dict, output_file_path):
    with open(output_file_path, 'w') as fasta_file:
        for seq_id, sequence in fasta_dict.items():
            fasta_file.write(f'>{seq_id}\n')
            fasta_file.write(f'{sequence}\n')

write_dict_to_fasta(core_dic,target_core_path)
write_dict_to_fasta(cloud_dic,target_cloud_path)