# -*- coding:utf-8 -*- 
# author：zhouyang

import pandas as pd
import MySQLdb
from util import rebuild_table, delete_table
import numpy as np

con = MySQLdb.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")

delete_table("user",con)

path = '/Users/zhouyang/Downloads/20160918/user.csv'

# read from csv file
df = pd.read_csv(path)

# strip every element in columns
columns = list(df)
columns = map(lambda x: x.strip(), columns)
df = df.ix[:, columns]

try:
    pd.io.sql.to_sql(df, 'user', con, flavor='mysql', if_exists='append', index=False)
except Exception,e:
    print e
    print 'there is an error, please fix it before continue!'
    exit(-1)

# transfer data to remote mysql server
yihuo_con = MySQLdb.connect(host="52.192.115.115", user="root", passwd="yihuo_root", port=3306, charset="utf8",
                            db="ezlife")
rebuild_table(table_name="user", con=yihuo_con, df=df)