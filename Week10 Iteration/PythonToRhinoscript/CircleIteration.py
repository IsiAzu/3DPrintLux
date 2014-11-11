# Create a circle from a center point and a circumference.
# Iterate until tiniest circle allowed.

import rhinoscriptsyntax as rs
import math

global center
global circumference

def CreateCircle():
    if center:
        plane = rs.MovePlane(rs.ViewCPlane(), center)
        length = circumference
        if length and length>10:
            radius = length/(2*math.pi)
            objectId = rs.AddCircle(plane, radius)
            rs.SelectObject(objectId)
            return length
    return None

# Check to see if this file is being executed as the "Main" python
# script instead of being used as a module by some other python script
# This allows us to use the module which ever way we want.
if __name__ == '__main__':
    center = rs.GetPoint("Center point of circle")
    circumference = rs.GetReal("Circle circumference")
    while(circumference > 5):
        CreateCircle()
        circumference -= 5 #make the circle smaller until max #

# NOTE: see UseModule.py sample for using this script as a module