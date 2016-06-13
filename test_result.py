# -*- coding:utf-8 -*- 
# author：zhouyang

import pandas as pd
import MySQLdb
import re
from datetime import datetime

con = MySQLdb.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")
path = "/Users/zhouyang/Downloads/20160603/test_result.csv"
df = pd.read_csv(path)

rename_dict = {
    "SOP_id": "sop_id",
    "amp": "current_amp",
    "stdwell": "std_well",
    "cvwell": "cv_well"
}
df = df.rename(columns=rename_dict)


def get_mix_str(sample_str, index):
    result = re.findall("mix\((.*?)\)", sample_str)
    if result is None or len(result) == 0:
        return ""
    result_str = result[index].strip()
    return result_str


def get_pre_treat_str(sample_str):
    # 正则表达式,最小匹配方式
    result = re.findall("pre_treat\((.*?)\)", sample_str)
    if result is None or len(result) == 0:
        return ""
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


df['date'] = df['date'].map(lambda x: x if pd.isnull(x) else str(int(x)))
df['date'] = df['date'].map(lambda x: x if pd.isnull(x) else transform_date(x))

pd.io.sql.to_sql(df, 'test_result', con, flavor='mysql', if_exists='append', index=False)
