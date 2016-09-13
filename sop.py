# -*- coding:utf-8 -*- 
# author：zhouyang

import pandas as pd
import MySQLdb
import re
import numpy as np
from util import rebuild_table,delete_table

con = MySQLdb.connect(host="127.0.0.1", port=3306, user="root", db="ezlife", charset="utf8")

# 删除原来表的内容
delete_table("sop",con)

path = "/Users/zhouyang/Downloads/20160906/sop.csv"
df = pd.read_csv(path)
# 重命名不符合规范的列
# 简化列名
rename_dict = {
    "SOP_id": "sop_id",
    "SOP_name": "sop_name",
    "Polymerization-Instructions": "step_1",
    "Sample-Instructions": "step_2",
    "Detector-Instructions": "step_3",
    "Reporter-Instructions": "step_4",
    "Readout-Instructions": "step_5"
}
df = df.rename(columns=rename_dict)


# 获取mix(str)
def get_mix_str(input):
    result = re.findall("mix\((.*?)\)", input)
    if len(result) == 0:
        return ""
    return result[0]


def get_pipette_str(input):
    result = re.findall("pipette\((.*?)\)", input)
    if len(result) == 0:
        return ""
    return result[0]


def get_efield_str(input):
    result = re.findall("efield\((.*?)\)", input)
    if len(result) == 0:
        return ""
    return result[0]


def get_incubation(input):
    result = re.findall("incubation\((.*?)\)", input)
    if len(result) == 0:
        return ""
    return result[0]


def get_wash_str(input):
    result = re.findall("wash\((.*?)\)", input)
    if len(result) == 0:
        return ""
    return result[0]


def get_mix_elem(mix_str, index):
    result_list = mix_str.split(",")
    if index >= len(result_list):
        print 'over bound! right'
        return ""
    return result_list[index]


def get_type_id(input_str):
    if input_str == "":
        return np.nan
    input_str = input_str.replace("_", "-")
    return int(input_str.split("-")[0])


def get_reagent_id(input_str):
    if input_str == "":
        return np.nan
    input_str = input_str.replace("_", "-")
    return int(input_str.split("-")[1])


def get_volumn(input_str):
    if input_str == "":
        return np.nan
    input_str = input_str.replace("_", "-")
    return input_str.split("-")[2]


# 利用正则表达式匹配数字,并将其转换为int数
def get_number(input_str):
    if input_str == "":
        return np.nan
    result = re.findall("\d+", input_str)
    return int(result[0])


# 获取方括号中间的内容,采用最小匹配
def get_str_between_brackets(input_str):
    result = re.findall("\[(.*?)\]", input_str)
    if len(result) == 0:
        print "efield wrong!please check it!"
        exit(-1)
    return result[0].replace("/", ",")


def get_efield_list_len(efield_str):
    result_list = efield_str.split(",")
    return len(result_list)


def get_efield_voltage1(efield_str):
    result_list = efield_str.split(",")
    return get_number(result_list[0])


def get_efield_duration1(efield_str):
    result_list = efield_str.split(",")
    return get_number(result_list[1])


def get_efield_voltage2(efield_str):
    result_list = efield_str.split(",")
    return get_number(result_list[2])


def get_efield_duration2(efield_str):
    result_list = efield_str.split(",")
    return get_number(result_list[3])


def get_cycles(efield_origin):
    result = re.findall("\*(\d+)", efield_origin)
    if len(result) == 0:
        print 'no cycles in efield! please check it!'
        exit(-1)
    return get_number(result[0])


for i in xrange(1, 6):
    step = "step_%d" % i
    df['mix_str'] = df[step].map(lambda x: get_mix_str(x))
    df['mix_list_len'] = df['mix_str'].map(lambda x: len(x.split(",")))
    # 找出第i步中mix中元素的最大数目 在第i步中,mix中的元素个数可能小于mix_len,出现提示over bound 正常
    max_len = df['mix_list_len'].max()
    del df['mix_list_len']
    for j in xrange(max_len):
        type_id = 'step%d_type_id_%d' % (i, j + 1)
        reagent_id = 'step%d_reagent_id_%d' % (i, j + 1)
        volumn = 'step%d_volumn_%d' % (i, j + 1)
        df[type_id] = df['mix_str'].map(lambda x: get_type_id(get_mix_elem(x, j)))
        df[reagent_id] = df['mix_str'].map(lambda x: get_reagent_id(get_mix_elem(x, j)))
        df[volumn] = df['mix_str'].map(lambda x: get_volumn(get_mix_elem(x, j)))
    del df['mix_str']
    pipette_volumn = 'step%d_pipette_volumn' % i
    df[pipette_volumn] = df[step].map(lambda x: get_number(get_pipette_str(x)))
    df['efield_str'] = df[step].map(lambda x: get_efield_str(x))
    df['efield_list_str'] = df['efield_str'].map(lambda x: get_str_between_brackets(x))
    df['efield_list_len'] = df['efield_list_str'].map(lambda x: get_efield_list_len(x))
    if len(df[df['efield_list_len'] == 4]) != len(df):
        print 'efield is wrong! please check it!'
        exit(-1)
    del df['efield_list_len']
    efield_voltage1 = "step%d_efield_vol1_voltage" % i
    efield_duration1 = "step%d_efield_vol1_duration" % i
    efield_voltage2 = "step%d_efield_vol2_voltage" % i
    efield_duration2 = "step%d_efield_vol2_duration" % i
    df[efield_voltage1] = df['efield_list_str'].map(lambda x: get_efield_voltage1(x))
    df[efield_duration1] = df['efield_list_str'].map(lambda x: get_efield_duration1(x))
    df[efield_voltage2] = df['efield_list_str'].map(lambda x: get_efield_voltage2(x))
    df[efield_duration2] = df['efield_list_str'].map(lambda x: get_efield_duration2(x))
    del df['efield_list_str']
    efield_cycles = "step%d_efield_cycles" % i
    df[efield_cycles] = df['efield_str'].map(lambda x: get_cycles(x))
    del df['efield_str']
    incubation = "step%d_incubation_duration" % i
    df[incubation] = df[step].map(lambda x: get_number(get_incubation(x)))
    wash = "step%d_wash" % i
    df[wash] = df[step].map(lambda x: get_wash_str(x))
    del df[step]

try:
    pd.io.sql.to_sql(df, 'sop', con, flavor='mysql', if_exists='append', index=False)
except Exception,e:
    print e
    print 'there is an error, please fix it before continue!'
    exit(-1)
    
# transfer data to remote mysql server
yihuo_con = MySQLdb.connect(host="52.192.115.115", user="root", passwd="yihuo_root", port=3306, charset="utf8",
                            db="ezlife")
rebuild_table(table_name="sop", con=yihuo_con, df=df)
