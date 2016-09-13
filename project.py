# -*- coding:utf-8 -*- 
# author：zhouyang
import pandas as pd
from datetime import datetime
import MySQLdb
from util import delete_table, rebuild_table

con = MySQLdb.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")

# 删除原来表的内容
delete_table('project', con)

# 因为含有中文,需要指定编码格式
df = pd.read_csv("/Users/zhouyang/Downloads/20160906/project.csv", encoding="gbk")

columns = ["_id", "catalogA", "catalogB", "catalogC", "attributes", "description", "create_at", "Mongodb_ID"]
df.columns = columns


# 将日期字符串转换为datetime数据类型
def transform_date(x):
    year = int(x[:4])
    month = int(x[4:6])
    # 月份出现了0,非法!
    if month <= 0:
        month = 1
    day = int(x[6:8])
    # 日期出现了0,非法!
    if day <= 0:
        day = 1
    hour = int(x[8:10])
    min = int(x[10:12])
    second = int(x[12:])
    return datetime(year=year, month=month, day=day, hour=hour, minute=min, second=second)


df['create_at'] = df['create_at'].map(lambda x: x if pd.isnull(x) else str(int(x)))
df['create_at'] = df['create_at'].map(lambda x: x if pd.isnull(x) else transform_date(x))

# pandas插入可以省略一些空的列
try:
    pd.io.sql.to_sql(df, 'project', con, flavor='mysql', if_exists='append', index=False)
except Exception,e:
    print e
    print 'there is an error, please fix it before continue!'
    exit(-1)
    
# transfer data to remote mysql server
yihuo_con = MySQLdb.connect(host="52.192.115.115", user="root", passwd="yihuo_root", port=3306, charset="utf8",
                            db="ezlife")
rebuild_table(table_name="project", con=yihuo_con, df=df)
