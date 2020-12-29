from PIL import Image
import numpy as np
import os

restart_message = "restart"

class GalagaEnvironment:

    def __init__(self, lost_live_penalty=3000, textfile="pass_data.txt", image_name="current_state.png"):
        self.lost_live_penalty = lost_live_penalty
        self.previous_score = 0
        self.previous_lives = 3
        self.image_name = image_name
        self.textfile = textfile

    def calculate_reward(self, score, lives):
        penalty = ((self.previous_lives - lives)*self.lost_live_penalty) if lives < self.previous_lives else 0 
        reward = abs(score - self.previous_score) - penalty
        self.previous_lives = lives
        self.previous_score = score
        return reward

    def get_screenshot(self):
        with Image.open(self.image_name) as img:
            aux = np.array(img)
        return aux

    def init(self):
        mod_date = os.path.getmtime(self.textfile)
        while mod_date == os.path.getmtime(self.textfile):
            pass

        image = self.get_screenshot()

        return image, 0


    def step(self, action):

        with open(self.textfile, "w") as f:
            line = f.write(action)

        mod_date = os.path.getmtime(self.textfile)
        while mod_date == os.path.getmtime(self.textfile):
            pass
        
        with open(self.textfile, "r") as f:
            line = f.readline().split()

        if line == restart_message:
            return None, None

        lives = int(line[0])
        score = int(line[1])

        reward = calculate_reward(score, lives)

        image = get_screenshot()

        return image, reward