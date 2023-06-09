#!/bin/bash
path=./logging/prw_final
filename=$path/BigLog.txt

#搜索大于10KB的文件
#-size +10k
#搜索小于10KB的文件
#-size -10k
#搜索等于10KB的文件
#-size 10k

if [ $# -ne 1 ]  
then  
        #echo "默认设置文件大小为500M"  
        filesize=500M
    else
        filesize=$1
fi 


echo "设置清除文件大小：$filesize"


if [  -f "$filename" ]; then    
    rm -rf $filename
    echo  "原始文件已删除"
else
    echo "$filename不存在"
fi 

find $path -name "*"  -size -$filesize -exec ls -lh {} \; | awk '{ print $5,$9}' > $filename

echo $filename
a=`echo "hello world"`
echo $a

for line in `cat $filename`
do
	#如果有匹配的内容则立即返回状态值0
    echo "$line" | grep  "error.txt" |grep -q $path
    # $? 是指上一条命令的执行状态， 0就是正常
    if [  $? -eq 0 ]
    then
    # then
    #     #获取文件类型
    #     filetype=${line#*.}
    #     if [ $filetype == "zip"  ];then
    #         echo "rm -rf $line"
    #         rm -rf $line
    #     else
    #         echo "执行清空命令 cat /dev/null > $line"
    #         # cat /dev/null  >  $line
    #     fi
    # dirname $line
    a=`dirname $line`
    echo $a
    echo "rm -rf $a"
    rm -rf $line
    fi
done

for line in `cat $filename`
do
	#如果有匹配的内容则立即返回状态值0
    echo "$line" | grep  "checkpoint" |grep -q $path
    # $? 是指上一条命令的执行状态， 0就是正常
    if [  $? -eq 0 ]
    then
    # then
    #     #获取文件类型
    #     filetype=${line#*.}
    #     if [ $filetype == "zip"  ];then
    #         echo "rm -rf $line"
    #         rm -rf $line
    #     else
    #         echo "执行清空命令 cat /dev/null > $line"
    #         # cat /dev/null  >  $line
    #     fi
    # dirname $line
    a=`dirname $line`
    b=`dirname $a`
    echo "$b"
    echo "mv $b ./checkpoints"
    mv $b ./checkpoints
    fi
done

rm -rf $path