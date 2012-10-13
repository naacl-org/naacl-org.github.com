import csv
import sys

def printinfo(istream):
    istream.next() # read header and discard
    for row in istream:
        print "h3. \"%s %s\":%s\n" % (row[0], row[1], row[5])
        print "h4. Bio\n\n", row[4], "\n"
        print "h4. Candidacy Statement\n\n", row[3], "\n\n"
        #print ', '.join(row)

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print >>sys.stderr, "usage: %s csv-file" % (sys.argv[0])
        sys.exit(1)
    with open(sys.argv[1], 'rb') as csvfile:
        fh = csv.reader(csvfile, delimiter=',')
        printinfo(fh)
