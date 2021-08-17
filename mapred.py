from sys import argv
import operator
import numpy

NULL, filename, filename2 = argv

of1 = open(filename, 'r')
of2 = open(filename2, 'w')
for line in of1.read().split('\n'):
    #print (line)
    x = list( map( int, line.split()))
    x2 = numpy.add(x, 1).tolist()
    #line2 = str(x2)
    #line2 = ''.join(x2)
    line2 = ' '.join(str(e) for e in x2)
    of2.write(line2 + "\n")
    





