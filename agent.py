import numpy as np
from collections import deque

class GalagaAgent:

    def __init__(self, num_actions):
        self.batch_size = num_actions
        self.last_actions = deque(maxlen=num_actions)
        self.create_model()

    def init(self, image, reward):
        for i in range(self.batch_size - 1):
            self.last_actions.appendleft((image, reward))
    
    def create_model(self):
        #crear modelo
        pass
    
    def save_model(self):
        #guardar pesos de la red neuronal
        pass

    def train_action(self, image, reward):
        self.last_actions.appendleft((image, reward))
        #Pasar por la red neuronal
        action = None
        return None

    def predict_action(self, image, reward):
        self.last_actions.appendleft((image, reward))
        #Pasar por la red neuronal
        action = None
        return None