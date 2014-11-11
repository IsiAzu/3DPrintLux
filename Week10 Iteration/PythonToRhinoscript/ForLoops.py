import rhinoscriptsyntax as rs

count = rs.GetInteger("Number of points")

for i in range(count):

    x = i

    y = i

    rs.AddPoint([x,y,0])