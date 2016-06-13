# -*- coding:utf-8 -*- 
# author：zhouyang
import pandas as pd
import MySQLdb
from datetime import datetime

con = MySQLdb.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")
df = pd.read_csv("/Users/zhouyang/Downloads/20160603/reagent.csv")

# 需要更换列名的列,及更换之后的列名对应关系
rename_dict = {
    "purchase_data": "purchase_date",
    "arrival_data": "arrival_date",
    "created_data": "create_date"
}
df = df.rename(columns=rename_dict)
df['purchase_date'] = df['purchase_date'].map(lambda x: x if pd.isnull(x) else str(int(x)))
df['arrival_date'] = df['arrival_date'].map(lambda x: x if pd.isnull(x) else str(int(x)))
df['create_date'] = df['create_date'].map(lambda x: x if pd.isnull(x) else str(int(x)))


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


df['purchase_date'] = df['purchase_date'].map(lambda x: x if pd.isnull(x) else transform_date(x))
df['arrival_date'] = df['arrival_date'].map(lambda x: x if pd.isnull(x) else transform_date(x))
df['create_date'] = df['create_date'].map(lambda x: x if pd.isnull(x) else transform_date(x))

pd.io.sql.to_sql(df, 'reagent', con, flavor='mysql', if_exists='append', index=False)
