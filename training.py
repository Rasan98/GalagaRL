import os

filename = "pass_data.txt"

while True:    
    mod_date = os.path.getmtime(filename)
    while mod_date == os.path.getmtime(filename):
        pass

    with open(filename, "r") as f:
        line = f.readline().split()

    if line == "exit":
        break
    lives = int(line[0])
    score = int(line[1])
    print(lives, score)

    #Call to slm lab

    with open(filename, "w") as f:
        line = f.write("000")

    mod_date = os.path.getmtime(filename)        



#Save slm lab model