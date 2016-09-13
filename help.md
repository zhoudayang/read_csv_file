### 数据导入文档
#### 1. 环境依赖
- python 2.7
- 需要安装 MySQLdb 模块。

>安装方法： 执行命令： ```pip install mysql python``` 如果安装此模块失败，可以换用pymysql模块，执行命令```pip install pymysql```可以安装pymysql模块。

- 需要在执行导入操作的主机上安装mysql数据库。 

#### 2.部署代码
* 从github上下载源码，此处需要使用版本控制工具git，执行命令：```git clone https://github.com/zhoudayang/read_csv_file.git```即可。该命令会在当前目录下生成文件夹**read\_csv\_file**,该文件夹下有源代码文件。为了区分使用MySQLdb模块，与使用pymysql模块来读取数据库，在代码仓库中建立了两个分支：**master**和**pymysql**。这两个分支分别对应使用MySQLdb与使用pymysql模块来读取数据库。可以根据需要执行命令```git checkout branch_name ```切换到指定分支来获取对应的源代码。如果不会使用版本控制工具git，在这里给出了上述两个分支的源代码文件的下载链接，分别是：
[master分支](https://pan.baidu.com/s/1mh7p2pM) 和 [pymysql分支](https://pan.baidu.com/s/1mhQmuoC)

#### 3.文件结构
在代码目录中，util.py中存放了一些公用工具方法的定义，其他所有的py文件对应一个导入表的小程序。例如：

1. efirms.py 是导入efirms表的程序。
2. eplate.py 是导入eplates表的程序。
3. project.py 是导入project表的程序。
4. reagent.py 是导入reagent表的程序。
5. sample.py 是导入sample表的程序。
6. sop.py 是导入sop表的程序。
7. test\_result.py 是导入test_result表的程序。
8. user.py 是导入user表的程序。

#### 4.运行前配置
为了避免直接修改服务器上的数据表，需要在本地mysql数据库上建立和服务器结构一致的表格，先尝试写入本地mysql服务器，确认无误之后再复写服务器上的mysql数据表。为了便于在本地建立和服务器上一致的数据表结构，我将服务器上相应表结构的建表语句导出为sql语句。对应文件 ezlife.sql，可以从下述路径下载：[ezlife.sql](https://raw.githubusercontent.com/zhoudayang/read_csv_file/master/ezlife.sql)。

在安装了mysql的电脑上建立对应表结构：执行下述命令：
```mysql -uUser -pPassword < ezlife.sql``` 注意将用户名**User**和密码**Password**替换为你的数据库的用户名和密码。

为了连接本地mysql数据库，可能需要修改 **3.文件结构** 中提及的几个导入表的代码文件。下面以test_result.py文件为例：

假设mysql IP地址为 192.168.1.1 用户名为 root ，密码为 admin， 端口号为 3306，那么con的定义应该修改为:
```con = MySQLdb.connect(host="192.168.1.1", port=3306, user="root", password="admin",db="ezlife", charset="utf8")
```
其他几个导入表数据的代码文件也要做出上述更改。
#### 5.执行导入操作
1. 在执行导入操作之前，请检查csv文件中列名和列的数量是否有误。因为记录数据时采用utf8编码，所以csv文件中不能有不符合规范的字符，例如中文符号（）、等。
2. 修改导入程序代码中的csv文件路径为你想要导入的csv文件路径。例如你想导入表**test\_result**,该文件路径为```/home/user/test_result.csv```,那么需要将test\_result中的path定义改为：```path="/home/user/test_result.csv```。如果是windows操作系统，csv文件路径假定为C:\data\test_result.csv,那么需要将test\_result中的path定义修改为：```path="C:\\data\\test_result.csv"```.
3. 执行python代码，将csv文件内容导入数据库。例如我们想导入表test\_result,并且已经参照2修改了test\_result.py文件,那么可以直接在命令行源代码文件路径下执行 ```python test_result.py```即可。如果程序没有报错:```there is an error, please fix it before continue!'``` ,则说明导入成功。否则请参照错误提示修改csv文件中的错误。目前已知的错误包括csv文件中出现了不符合数据库要求的中文符号，csv文件的列数或者列名不对，现有的csv文件内容不符合数据库表约束条件等。请参照错误提示修改csv文件，再次进行导入操作。**其他数据表的导入操作完全一致，参照本文中test_result表的导入操作即可。**
