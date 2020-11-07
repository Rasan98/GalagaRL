import os

filename = "pass_data.txt"
i = 10

while i <= 10:
    i = i - 1    
    mod_date = os.path.getmtime(filename)
    while mod_date == os.path.getmtime(filename):
        pass

    with open(filename, "r") as f:
        line = f.readline().split()
        lives = int(line[0])
        score = int(line[1])
        print(lives, score)
    
    #Llamada a slm lab

    with open(filename, "w") as f:
        line = f.write("000")

    mod_date = os.path.getmtime(filename)        
