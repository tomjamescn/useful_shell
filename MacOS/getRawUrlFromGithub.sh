#!/bin/bash

#从github获取原始文件url
#用法: sh xxx.sh 项目名称 文件路径
#

url="https://raw.githubusercontent.com/tomjamescn/$1/master/$2"


#复制到剪切板
echo $url | pbcopy


echo $url
echo "已经复制到剪切板中\n\n"
