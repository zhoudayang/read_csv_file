# -*- coding:utf-8 -*- 
#author：zhouyang
import pandas as pd
import MySQLdb

con = MySQLdb.connect(host="127.0.0.1",port=3306,user="root",db="ezlife",charset ="utf8")

# delete before insert
cur = con.cursor()
delete_sql = "delete from efirms"
cur.execute(delete_sql)
con.commit()
cur.close()

df = pd.read_csv("/Users/zhouyang/Desktop/efirms.csv")
pd.io.sql.to_sql(df, 'efirms', con, flavor='mysql', if_exists='append', index=False)
