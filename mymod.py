import math
def mymod(x,xmin,xmax):
    l = xmax - xmin
    while x < xmin:
        x += l
    while x > xmax:
        x -= l
    
    return x 
