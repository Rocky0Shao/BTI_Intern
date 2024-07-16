def count_greater_than(file_path):
    count = 0
    with open(file_path, 'r') as file:
        for line in file:
            count += line.count('>')
    return count

# Example usage
file_path = r"C:\Users\Fei Lab\Desktop\Intern_Git\BTI_Intern\Pre_Anotation\Total.fa"
greater_than_count = count_greater_than(file_path)
print(f'The number of ">" characters in {file_path} is: {greater_than_count}')
