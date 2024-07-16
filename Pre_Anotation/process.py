import os
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

def process_files(source_dir, out_file):
    all_files = []

    # Collect all files with .fa extension
    for root, dirs, files in os.walk(source_dir):
        for file in files:
            if file.endswith('.fa'):
                file_path = os.path.join(root, file)
                all_files.append(file_path)

    # Sort the files based on their names
    all_files.sort()

    # Process each file in the sorted order
    for file_path in all_files:
        file_name_no_extension = get_filename_without_extension(file_path)
        file_dic = read_fasta_to_dict(file_path)
        longest_value = get_longest_value(file_dic)
        small_dic = {file_name_no_extension: longest_value}
        write_dict_to_fasta(small_dic, out_file)

def read_fasta_to_dict(file_path):
    fasta_dict = {}
    for seq_record in SeqIO.parse(file_path, "fasta"):
        fasta_dict[seq_record.id] = str(seq_record.seq)
    return fasta_dict

def get_filename_without_extension(file_path):
    base_name = os.path.basename(file_path)
    name, _ = os.path.splitext(base_name)
    return name

def get_longest_value(d):
    longest_value = None
    for key, value in d.items():
        if longest_value is None or len(value) > len(longest_value):
            longest_value = value
    return longest_value

def write_dict_to_fasta(fasta_dict, output_file_path):
    seq_records = []
    for key, value in fasta_dict.items():
        seq_record = SeqRecord(Seq(value), id=key, description="")
        seq_records.append(seq_record)
    with open(output_file_path, "a") as output_handle:
        SeqIO.write(seq_records, output_handle, "fasta")

# Define the source and destination directories
source_directory = '/data/rocky/pre_annotation/orthogroups'
out_file = '/data/rocky/pre_annotation/Total.fa'

# Call the function to process the files
process_files(source_directory, out_file)
