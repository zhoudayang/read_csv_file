# -*- coding:utf-8 -*- 
# author：zhouyang

import pymysql
import pandas as pd
from datetime import datetime
import numpy as np
from util import rebuild_table,delete_table
import re


con = pymysql.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")

# 删除原来表的内容
delete_table("sample",con)

df = pd.read_csv("/Users/zhouyang/Downloads/20160906/sample.csv")

# 需要更换列名的列,及更换之后的列名对应关系
rename_dict = {
    "OD_or_amount": "od_or_amount",
    "Purification": "purification",
    "5_mod": "mod_5",
    "3_mod": "mod_3",
    "purchase_data": "purchase_date",
    "arrival_data": "arrival_date",
    "created_data": "create_date"
}
df = df.rename(columns=rename_dict)


# 删除可能多出的列
# columns = list(df)
# columns = columns[:19]
# df = df.ix[:, columns]

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
    pd.io.sql.to_sql(df, 'sample', con, flavor='mysql', if_exists='append', index=False)
except Exception,e:
    print e
    print 'there is an error, please fix it before continue!'
    exit(-1)

# transfer data to remote mysql server
yihuo_con = pymysql.connect(host="52.192.115.115", user="root", passwd="yihuo_root", port=3306, charset="utf8",
                            db="ezlife")
rebuild_table(table_name="sample", con=yihuo_con, df=df)
