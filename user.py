# -*- coding:utf-8 -*- 
# author：zhouyang

import pandas as pd
import pymysql
from util import rebuild_table, delete_table
import numpy as np

con = pymysql.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")

path = '/Users/zhouyang/Downloads/20160718/user.csv'

# read from csv file
df = pd.read_csv(path)

# strip every element in columns
columns = list(df)
columns = map(lambda x: x.strip(), columns)
df = df.ix[:, columns]

pd.io.sql.to_sql(df, 'user', con, flavor='mysql', if_exists='append', index=False)
