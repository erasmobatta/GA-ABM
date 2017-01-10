import random
import math
from mymod import mymod

class Source:
    empCount = 0

    def __init__(self, x, y, energy):
        self.x = x
        self.y = y
        self.energy = energy
        Source.empCount += 1

class Environment:
    def __init__(self, height, width, numcells, boundaries):
        self.height = height
        self.width = width
        self.numcells = numcells
        self.boundaries = boundaries
        self.sources = []
    def growsources(self,energy):
        for i in range(self.numcells):
            for j in range(self.numcells):
                di=self.width/(2*self.numcells)
                dj=self.height/(2*self.numcells)
                self.sources.append(Source(i+di,j+dj,energy))

class Agent:
    empCount = 0

    def __init__(self, x, y, energy, consume):
        self.x = x
        self.y = y
        self.theta = 2 * math.pi * random.random()
        self.energy = energy
        self.consume = consume
        Agent.empCount += 1
        self.ID = Agent.empCount

    def move(self, environment):
        self.x = self.x + math.cos(self.theta) * self.consume
        self.y = self.y + math.sin(self.theta) * self.consume
        if environment.boundaries == 'periodic':
            self.x = mymod(self.x, 0, environment.width)
            self.y = mymod(self.y, 0, environment.height)
        self.theta = 2 * math.pi * random.random()
        self.energy = self.energy - self.consume

    def sourcedistance(self,source,environment):
        dx=mymod(abs(self.x - source.x),0,environment.width/2)
        dy=mymod(abs(self.y - source.y),0,environment.height/2)
        return math.sqrt(dx**2 + dy**2)

    def sourceangle(self, source, environment):
        dx=source.x - self.x
        dy=source.y - self.y
        if dx > environment.width/2:
            dx = -(environment.width-dx)
        if dx < -environment.width/2:
            dx = environment.width + dx
        if dy > environment.height/2:
            dy = -(environment.height-dy)
        if dy < -environment.height/2:
            dy = environment.height + dy
        if dx!=0:
            return math.atan(dy/dx)
        elif dy==0:
            return 0
        elif dy>0:
            return math.pi
        else:
            return 3*math.pi/4

    def eat(self,environment,cone,visionTh):
        for so in environment.sources:
            sd=self.sourcedistance(so,environment)
            sa=self.sourceangle(so,environment)
            if sd< self.consume+cone and sd<self.theta+visionTh/2 and sd>self.theta-visionTh/2:
                self.energy = self.energy + so.energy
                environment.sources.remove(so)

    #def reproduce(self, abm):
        #if self.energy >= 2 * abm.energyZero:
            #self.energy = self.energy / 2
            #abm.agents.append(Agent(self.x,self.y,self.energy,self.consume))
    
class AgentSystem:
    def __init__(self, energyZero, basalMet, visionTh, cone, environment):
        self.energyZero = energyZero
        self.basalMet = basalMet
        self.visionTh = visionTh
        self.cone = cone
        self.environment = environment
        self.agents = []
        self.time = 0
        self.agentEnergy = 0
        self.sourceEnergy = 0
        self.population = 0
        self.lowFraction = 0

    def setglobals(self):
        self.population = len(self.agents)
        #lc = min([ag.consume for ag in self.agents])
        lc = 1.5
        self.lowFraction = len([ag for ag in self.agents if ag.consume == lc])
        #self.agentEnergy = sum([ag.energy for ag in self.agents]) 
        #self.sourceEnergy = sum([so.energy for so in self.environment.sources])

    def setup(self, myseed, initPop, LowFraction, LowC, HighC,sourceEnergy):
        random.seed(myseed)
        self.environment.growsources(sourceEnergy)
        
        for i in range(0, initPop):
            if i < LowFraction * initPop:
                self.agents.append(Agent(random.random() * self.environment.height
                                         , random.random() * self.environment.width
                                         , self.energyZero, LowC))
            else:
                self.agents.append(Agent(random.random() * self.environment.height
                                         , random.random() * self.environment.width
                                         , self.energyZero, HighC))
        self.setglobals()        
        
    def go(self, sourceEnergy):
        for ag in self.agents:
            ag.energy = ag.energy - self.basalMet
            ag.move(self.environment)
            ag.eat(self.environment,self.cone,self.visionTh)
            if ag.energy >= 2 * self.energyZero:
                ag.energy = ag.energy / 2
                self.agents.append(Agent(ag.x,ag.y,ag.energy,ag.consume))
            elif ag.energy < 0:
                self.agents.remove(ag)
        if len(self.environment.sources) < 10:
            self.environment.growsources(sourceEnergy)        
        self.setglobals()        
        self.time += 1
