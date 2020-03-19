#!/bin/bash
#演示平台镜像地址
#registry="192.168.36.1:5000/lyzhxg/"
#开发环境
registry="192.168.35.105:5000/lyzhxg/"
#测试环境
#registry="192.168.35.116:5000/lyzhxg/"

#上传仓库位置
if [ -n "$1" ] ;then
	registry=$1
fi

echo "上传镜像仓库地址："
echo $registry

n=0

while read line
do
	if [[ "$line" =~ ^# ]] ;
	then
		continue
	else
		imagearr[$n]=$line
		((n+=1))
	fi
done < 'images.txt'

echo "本次要推送的镜像有："

for var in ${imagearr[@]}
do
	echo ${var}
done


#循环下载、上传
for var in ${imagearr[@]}
do
	#下载镜像
	echo "exec shell exec 'docker pull $var'"
	docker pull $var
	
	#获取完整的镜像名
	imageFullName=`docker images --format "{{.Repository}}:{{.Tag}}:{{.ID}}" |grep $var`
	echo $imageFullName

	#获取imageid	
	ID=${imageFullName##*:}
	echo $ID

	#获取镜像名
	imageName=${imageFullName##*/}
	imageName=${imageName%%:*}

	#生成tag
	tag=`date +%Y%m%d-%H%M%S`

	newImgPath=$registry$imageName:$tag
	echo $newImgPath


	docker tag $ID $newImgPath
	docker push $newImgPath
	docker rmi -f $ID
done
