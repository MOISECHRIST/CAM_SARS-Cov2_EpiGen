#!/Users/macbookpro/miniforge3/envs/tensorflow/bin/python

import argparse
from Bio import SeqIO
import pandas as pd
from pathlib import Path

def read_fasta_file(path_to_fasta_file):
  
  all_fasta = []
  try:
    with open(path_to_fasta_file, "r") as fasta_file:
      for fasta in SeqIO.parse(fasta_file, "fasta"):
        all_fasta.append(fasta)
      
  except FileNotFoundError:
    print(f"Error: The file '{path_to_fasta_file}' is not found.")
    return
  
  return all_fasta
  

def read_rename_file(path_to_rename_file):
  
  file_path = Path(path_to_rename_file)
  
  if file_path.suffix != ".csv":
    print("Error: Unexpected file extension. The file must end with '.csv' and contain comma-separated values.")
    return
  
  try:
    data =  pd.read_csv(path_to_rename_file, sep=",")
  
  except FileNotFoundError:
    print(f"Error: The file '{path_to_fasta_file}' is not found.")
    return
  
  if "old_name" not in data.columns or "new_name" not in data.columns:
    print(f"Error: The expected columns 'old_name' and 'new_name' are not found.")
    return
  
  else:
    return data
  
def rename_fasta_id(fasta_list, old_name_list, new_name_list):
  
  renamed_fasta = []
  
  for fasta in fasta_list:
    try:
      index = old_name_list.index(fasta.id)
      fasta.id = new_name_list[index]
      fasta.description = fasta.id
      
      renamed_fasta.append(fasta)
    except:
      print(f"Error: The fasta id '{fasta.id}' is not found in the old list names.")
      continue
  
  return renamed_fasta
      

def record_fasta_file(fasta_data, path_to_record):
  
  with open(path_to_record, "w") as outfile:
    SeqIO.write(fasta_data, outfile, "fasta")
    

def main():
  
  description = (
            "Rename FASTA using csv file."
            " Requires a file with all olds and new sample names, FASTA file and an output file name."
            " The csv file must have 2 columns : old_name, new_name"
        )

  parser = argparse.ArgumentParser(description=description)
        
  parser.add_argument("--data", "-d", required=True, help="Path to the file containing samples names.")
  parser.add_argument("--fasta", "-f", required=True, help="Path to the fasta file.")
  parser.add_argument("--output", "-o", required=True, help="Path to the output file.")

  args = parser.parse_args()
  
  all_fasta = read_fasta_file(args.fasta)
  data = read_rename_file(args.data)
  if data is None or all_fasta is None:
    return
  
  else:
    
    renamed_fasta = rename_fasta_id(all_fasta, list(data["old_name"]), list(data["new_name"]))
    record_fasta_file(renamed_fasta, args.output)
    
if __name__ == "__main__":
  main()
  
