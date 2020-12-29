from agent import GalagaAgent
from environment import GalagaEnvironment
import sys

ag = GalagaAgent()
env = GalagaEnvironment()

#Initialize environment and agent
image, reward = env.init()
ag.init(image, reward)

print("Environment and agent initialized")

#Type of execution (train, play)
if sys.argv[1] == "train":
    agent_function = ag.train_action
else:
    agent_function = ag.predict_action


#Run until press Ctrl+C
try:
    while True:
        #Predict and train the neural net
        
        action = agent_function(image, reward)
        print("Action predicted --> ", action)

        #Apply action to environment
        image, reward = env.step(action)
        print("Last action reward --> ", reward)

        #If game is over, restart agent and environment
        if reward is None:
            print("Game Over, restarting agent and environment")
            image, reward = env.init()
            ag.init(image, reward)
except KeyboardInterrupt:
    ag.save_model()

print("Model saved")