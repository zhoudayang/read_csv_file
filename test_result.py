# -*- coding:utf-8 -*- 
# author：zhouyang

import pandas as pd
import MySQLdb
import re
from datetime import datetime
import numpy as np
from util import rebuild_table,delete_table


con = MySQLdb.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")

# 删除原来表的内容
delete_table("test_result",con)

path = "/Users/zhouyang/Downloads/20160906/test_result.csv"
df = pd.read_csv(path)

rename_dict = {
    "SOP_id": "sop_id",
    "amp": "current_amp",
    "stdwell": "std_well",
    "cvwell": "cv_well",
    "Ispositive":"is_positive"
}
df = df.rename(columns=rename_dict)


def get_mix_str(sample_str, index):
    result = re.findall("mix\((.*?)\)", sample_str)
    if result is None or len(result) == 0:
        return np.nan
    result_str = result[index].strip()
    return result_str


def get_pre_treat_str(sample_str):
    # 正则表达式,最小匹配方式
    result = re.findall("pre_treat\((.*?)\)", sample_str)
    if result is None or len(result) == 0:
        return np.nan
    result_str = result[0].strip()
    return result_str


def get_mix_len(sample_str):
    result = re.findall("mix\((.*?)\)", sample_str)
    return len(result)


df['pre_treat'] = df['sample'].map(lambda x: get_pre_treat_str(x))


def get_sample_type_id(mix_str):
    mix_str = mix_str.replace("_", "-")
    result_list = mix_str.split("-")
    return int(result_list[0])


def get_sample_reagent_id(mix_str):
    mix_str = mix_str.replace("_", "-")
    result_list = mix_str.split("-")
    return int(result_list[1])


def get_sample_concentration(mix_str):
    mix_str = mix_str.replace("_", "-")
    result_list = mix_str.split("-")
    return result_list[2]


df['mix_len'] = df['sample'].map(lambda x: get_mix_len(x))
mix_len = df['mix_len'][0]
len_of_df = len(df)
if len(df[df['mix_len'] == mix_len]) != len_of_df:
    print 'please check mix str in sample! it is wrong!'
    exit(-1)
del df['mix_len']

for i in xrange(1, mix_len + 1):
    name1 = 'sample_type_id_%d' % i
    name2 = 'sample_reagent_id_%d' % i
    name3 = 'sample_concentration_%d' % i
    df[name1] = df['sample'].map(lambda x: get_sample_type_id(get_mix_str(x, i - 1)))
    df[name2] = df['sample'].map(lambda x: get_sample_reagent_id(get_mix_str(x, i - 1)))
    df[name3] = df['sample'].map(lambda x: get_sample_concentration(get_mix_str(x, i - 1)))

del df['sample']


def transform_date(date_str):
    if re.match("\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}", date_str) is None:
        print 'date string is not right please check it later!'
        return np.nan
    return datetime.strptime(date_str, "%Y-%m-%d-%H-%M-%S")


df['date'] = df['date'].map(lambda x: x if pd.isnull(x) else transform_date(x))

try:
    pd.io.sql.to_sql(df, 'test_result', con, flavor='mysql', if_exists='append', index=False)
except Exception,e:
    print e
    print 'there is an error, please fix it before continue!'
    exit(-1)

# transfer data to remote mysql server
yihuo_con = MySQLdb.connect(host="52.192.115.115", user="root", passwd="yihuo_root", port=3306, charset="utf8",
                            db="ezlife")
rebuild_table(table_name="test_result", con=yihuo_con, df=df)
