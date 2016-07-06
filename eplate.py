# -*- coding:utf-8 -*- 
# author：zhouyang
import pandas as pd
from datetime import datetime
import MySQLdb
import numpy as np
import re

# 删除了列barcode,和列bar_code重复
con = MySQLdb.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")

# 删除原来表的内容
delete_sql = "delete from eplates"
cur = con.cursor()
cur.execute(delete_sql)
con.commit()
cur.close()

path = "/Users/zhouyang/Downloads/20160706/eplate.csv"
df = pd.read_csv(path)
# 更换列的名称
df = df.rename(columns={"eplate_types_id": "eplate_type_id"})


def transform_date(date_str):
    if re.match("\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}", date_str) is None:
        print 'date string is not right please check it later!'
        return np.nan
    return datetime.strptime(date_str, "%Y-%m-%d-%H-%M-%S")


df['create_at'] = df['create_at'].map(lambda x: x if pd.isnull(x) else transform_date(x))
df['batch_date'] = df['batch_date'].map(lambda x: x if pd.isnull(x) else transform_date(x))

if 'barcode' in list(df):
    # 这个字段在原数据表中不存在,删除
    del df['barcode']

pd.io.sql.to_sql(df, 'eplates', con, flavor='mysql', if_exists='append', index=False)
