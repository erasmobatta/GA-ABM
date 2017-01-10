import random
import math

class Agent:

    empCount = 0
    def __init__(self,x,y,energy,consume):
        self.x = x
        self.y = y
        self.theta = 2*math.pi*random.random()
        self.energy = energy
        self.consume = consume
        Agent.empCount += 1
        self.ID = Agent.empCount

class Environment:
    def __init__(self,height,width,division):
        self.height = height
        self.width = width
        self.division = division
        
class AgentSystem:
    def __init__(self,energyZero,basalMet,visionTh,cone,environment):
        self.energyZero = energyZero
        self.basalMet = basalMet
        self.visionTh = visionTh
        self.cone = cone
        self.environment = environment
        self.agents = []
        
    def setup(self,myseed,initPop,LowFraction,LowC,HighC):
        random.seed(myseed)
        for i in range(0,initPop):
            if i < LowFraction*initPop:
                self.agents.append(Agent(random.random()*self.environment.height
                            ,random.random()*self.environment.width
                            ,self.energyZero,LowC))
            else:
                self.agents.append(Agent(random.random()*self.environment.height
                            ,random.random()*self.environment.width
                            ,self.energyZero,HighC))
        
                
    
