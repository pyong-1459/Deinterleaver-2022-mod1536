f_vector = open("vector1.txt", 'w')

index = [0, 768, 384, 1152, 1344, 192, 960, 576]

for i in range(1536):
    for j in range(8):
        data_bin = f'{index[j]:011b}'
        # print(data_bin)
        f_vector.write(data_bin + "\n")
        index[j] = (index[j] + 1) % 1536

f_vector.close()
