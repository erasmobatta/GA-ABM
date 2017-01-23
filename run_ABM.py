import time
start_time = time.time()
import sys
import math
import os
sys.path.append(os.getcwd()+'/sources')
from sources.abmComponents import AgentSystem
from sources.abmComponents import Environment

#System globals

initPop = 100 
energyZero = 10 # Initial energy from every agent
LCIF = 0.5 # Low Consume Initial Fraction
HC=2.0 # Low consume
LC=1.5 # High consume
args = sys.argv

basalMet = float(args[1])
visionTh = float(args[2])
cone = float(args[3])

heightEnv=10
widthEnv=10
numcells=10
boundaries='periodic'
sourceEnergy=1
myseed=6
MaxGens=100

# creation of system of agents (agents + environment)

environment=Environment(heightEnv, widthEnv, numcells, boundaries)
abm=AgentSystem(energyZero, basalMet, visionTh, cone, environment)
abm.setup(myseed, initPop, LCIF, LC, HC, sourceEnergy)

while abm.population>0 and abm.time < MaxGens:
    abm.go(sourceEnergy)
    #print(abm.time,abm.population,abm.lowFraction)

print(abm.population)
print(abm.lowFraction)

 
