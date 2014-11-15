#!/usr/bin/python
import psycopg2
conn = psycopg2.connect(database="chimera", user="postgres", password="", host="127.0.0.1", port="5432")
cur = conn.cursor() 
cur.execute("INSERT INTO t_locationinfo(ipnfsid, itype, ilocation, ipriority, ictime, iatime, istate)VALUE(%s, %d, %s, %d, %t, %d)",())
cur.execute("INSERT INTO t_retention_policy(ipnfsid, iretentionpolicy)VALUE()",())
cur.execute("INSERT INTO t_stroageinfo(ipnfsid, ihsmname, istoragegroup, istoragesubgroup)VALUE()",())
cur.execute("INSERT INTO t_inodes_checksum(ipnfsid, itype, isum)VALUE()",())
cur.execute("INSERT INTO t_level_2(ipnfsid, imode, inlink, iuid, igid, isize, ictime, iatime, imtime, ifiledata)VALUE()",())

conn.close()

