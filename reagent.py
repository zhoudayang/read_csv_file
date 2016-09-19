# -*- coding:utf-8 -*-
# author：zhouyang
import pandas as pd
import MySQLdb
from datetime import datetime
import numpy as np
from util import delete_table, rebuild_table
import re
import chardet

con = MySQLdb.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")

# 删除原来表的内容
delete_table("reagent", con)

df = pd.read_csv("/Users/zhouyang/Downloads/20160918/reagent.csv")

# 需要更换列名的列,及更换之后的列名对应关系
rename_dict = {
    "purchase_data": "purchase_date",
    "arrival_data": "arrival_date",
    "created_data": "create_date"
}
df = df.rename(columns=rename_dict)



def change_encode(df,column):
    for i in df.index:
        value = df[column][i]
        if pd.isnull(value):
            continue
        encode = chardet.detect(value)["encoding"]
        if encode != "ascii":
            df[column][i] = value.decode(encode)
    return df

df = change_encode(df,"supplier")
df = change_encode(df,"attributes")

# 将日期字符串转换为datetime数据类型
def transform_date(date_str):
    if re.match("\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}", date_str) is None:
        print 'date string is not right please check it later!'
        return np.nan
    return datetime.strptime(date_str, "%Y-%m-%d-%H-%M-%S")


df['purchase_date'] = df['purchase_date'].map(lambda x: x if pd.isnull(x) else transform_date(x))
df['arrival_date'] = df['arrival_date'].map(lambda x: x if pd.isnull(x) else transform_date(x))
df['create_date'] = df['create_date'].map(lambda x: x if pd.isnull(x) else transform_date(x))

try:
    pd.io.sql.to_sql(df, 'reagent', con, flavor='mysql', if_exists='append', index=False)
except Exception, e:
    print e
    print 'there is an error, please fix it before continue!'
    exit(-1)

# 此处表结构有变化,需要使用navicat进行数据同步


# transfer data to remote mysql server
yihuo_con = MySQLdb.connect(host="52.192.115.115", user="root", passwd="yihuo_root", port=3306, charset="utf8",
                            db="ezlife")
rebuild_table(table_name="reagent", con=yihuo_con, df=df)
