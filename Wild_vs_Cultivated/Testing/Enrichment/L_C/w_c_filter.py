import pandas as pd
import sys

cultivated_file = r"/home/rocky/BTI/BTI_Intern/Wild_vs_Cultivated/Testing/Enrichment/PAV/cultivated_1.5.tsv"
wild_file = r"/home/rocky/BTI/BTI_Intern/Wild_vs_Cultivated/Testing/Enrichment/PAV/landscape_1.5.tsv"

cultivated_df = pd.read_csv(cultivated_file, sep = '\t')
wild_df = pd.read_csv(wild_file, sep = '\t')



c_special = ""
w_special = ""

cultivated_df.iloc[:, 2] = cultivated_df.iloc[:, 2] + 1e-16
wild_df.iloc[:, 2] = wild_df.iloc[:, 2] + 1e-16

c_3rd_col = cultivated_df.iloc[:, 2]
w_3rd_col = wild_df.iloc[:,2]
print("added small")
for i in range(len(cultivated_df)):
    w = w_3rd_col.iloc[i]
    c = c_3rd_col.iloc[i]
    
    if (w/c >= 1.5):
        w_special += wild_df.iloc[i,0]
        w_special += '\t'
        w_special += '\n'
        
    if (c/w >= 1.5):
        c_special += cultivated_df.iloc[i,0]
        c_special += '\t'
        c_special += '\n'
print("donemost, not saved")
def save_string_to_file(file_path, content):
    with open(file_path, 'w') as file:
        file.write(content)
    # print(f"Content saved to {file_path}")
    
save_string_to_file(r"/home/rocky/BTI/BTI_Intern/Wild_vs_Cultivated/Testing/Enrichment/L_C/landscape.txt",w_special)
save_string_to_file(r"/home/rocky/BTI/BTI_Intern/Wild_vs_Cultivated/Testing/Enrichment/L_C/cultivated.txt", c_special)
