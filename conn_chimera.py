#!/usr/bin/python

# args from 1 to n : 1 pnfsid, 2 isum, 3 pnfspath, 4 imode, 5 iuid, 6 igid, 7 fileatime , 10 filectime, 13 filemtime
import psycopg2
import os, sys
fileatime = sys.argv[7] + " " + sys.argv[8] + " " + sys.argv[9]
filectime = sys.argv[10] + " " + sys.argv[11] + " " + sys.argv[12]
filemtime = sys.argv[13] + " " + sys.argv[14] + " " + sys.argv[15]
ilocation = "osm://osm/?store=bes3fs&group=bes&bfid=" + sys.argv[3]
conn = psycopg2.connect(database="chimera", user="postgres", password="", host="127.0.0.1", port="5432")
cur = conn.cursor()
cur.execute("INSERT INTO t_locationinfo(ipnfsid, itype, ilocation, ipriority, ictime, iatime, istate)VALUES(%s, %s, %s, %s, %s, %s, %s)",(sys.argv[1], "0", ilocation, "10", filectime, fileatime, "1",))
cur.execute("INSERT INTO t_retention_policy(ipnfsid, iretentionpolicy)VALUES(%s, %s)",(sys.argv[1], "0"))
cur.execute("INSERT INTO t_storageinfo(ipnfsid, ihsmname, istoragegroup, istoragesubgroup)VALUES(%s, %s, %s, %s)",(sys.argv[1], "osm", "bes3fs", "bes"))
cur.execute("INSERT INTO t_inodes_checksum(ipnfsid, itype, isum)VALUES(%s, %s, %s)",(sys.argv[1], "1", sys.argv[2]))
cur.execute("INSERT INTO t_level_2(ipnfsid, imode, inlink, iuid, igid, isize, ictime, iatime, imtime)VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s)",(sys.argv[1], sys.argv[4], "1", sys.argv[5], sys.argv[6], "22", filectime, fileatime, filemtime))

conn.commit()
cur.close()
conn.close()
#print ilocation

