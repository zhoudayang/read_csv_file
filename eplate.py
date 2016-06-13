# -*- coding:utf-8 -*- 
# author：zhouyang
import pandas as pd
from datetime import datetime
import MySQLdb

# 删除了列barcode,和列bar_code重复
con = MySQLdb.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")
path = "/Users/zhouyang/Downloads/20160603/eplate.csv"
df = pd.read_csv(path)
# 将create_at这一列转换为字符串类型
df['create_at'] = df['create_at'].map(lambda x: x if pd.isnull(x) else str(int(x)))
df['batch_date'] = df['batch_date'].map(lambda x: x if pd.isnull(x) else str(int(x)))
# 更换列的名称
df = df.rename(columns={"eplate_types_id": "eplate_type_id"})


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


df['create_at'] = df['create_at'].map(lambda x: x if pd.isnull(x) else transform_date(x))
df['batch_date'] = df['batch_date'].map(lambda x: x if pd.isnull(x) else transform_date(x))

pd.io.sql.to_sql(df, 'eplates', con, flavor='mysql', if_exists='append', index=False)
