import csv
import pandas as pd
from Bio import SeqIO

target_core_path = r"C:\Users\Fei Lab\Desktop\Intern_Git\BTI_Intern\Blast\Core_Pan_Genes\Core_Genes.fa"
target_cloud_path = r"C:\Users\Fei Lab\Desktop\Intern_Git\BTI_Intern\Blast\Core_Pan_Genes\Cloud_Genes.fa"

def write_dict_to_fasta(fasta_dict, output_file_path):
    with open(output_file_path, 'w') as fasta_file:
        for seq_id, sequence in fasta_dict.items():


write_dict_to_fasta(core_dic,target_core_path)
write_dict_to_fasta(cloud_dic,target_cloud_path)