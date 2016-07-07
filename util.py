# -*- coding:utf-8 -*- 
# author：zhouyang
import pandas as pd


# 存放一些工具方法


# 删除表中数据
def delete_table(table_name, con):
    cur = con.cursor()
    delete_sql = "delete from %s " % table_name
    cur.execute(delete_sql)
    con.commit()
    cur.close()


# 删除表中数据，并向表中插入新的数据
def rebuild_table(table_name, con, df):
    delete_table(table_name, con)
    pd.io.sql.to_sql(df, table_name, con, flavor='mysql', if_exists='append', index=False)
