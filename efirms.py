# -*- coding:utf-8 -*- 
# author：zhouyang
import pandas as pd
import pymysql
from util import delete_table, rebuild_table

con = pymysql.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")

# delete before insert
delete_table("efirms", con)

df = pd.read_csv("/Users/zhouyang/Downloads/20160906/efirms.csv")
try:
    pd.io.sql.to_sql(df, 'efirms', con, flavor='mysql', if_exists='append', index=False)
except Exception,e:
    print e
    print 'there is an error, please fix it before continue!'
    exit(-1)

# transfer data to remote mysql server
yihuo_con = pymysql.connect(host="52.192.115.115", user="root", passwd="yihuo_root", port=3306, charset="utf8",
                            db="ezlife")
rebuild_table(table_name="efirms", con=yihuo_con, df=df)
