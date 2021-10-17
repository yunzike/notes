## 1、介绍

- MESOS

  APACHE   分布式资源管理框架    2019-5      witter--》kubernetes

- Docker swarm

  2019-07              阿里云宣布    将 Docker swarm   剔除

- Kubernetes

  Google               10年容器化基础架构 borg                GO语言  Borg 

  特点

  轻量级：消耗资源小

  开源

  弹性伸缩

  负载均衡：IPVS



介绍说明:

前世今生 KUbernetes框架 KUbernetes关键字含义

基础概念:

仕么是Pod控制器类型K8s网絡通讯模式

Kubernetes:

构建K8s集群

资源清单:

资源掌握资源淸单的语法編写Pod掌握Pod的生命周期**

Pod控制器:

掌握各种控制器的特点以及使用定义方式

服务发现:

掌握svc原理及其构建方式























## 2、组件

APISERVER:所有服务访问统一入口

CrontrollerManager:维持副本期望数目

Scheduler;:负责介绍任务,选择合适的节点进行分配任务

ETCD:键值对数据库储存K8s集群所有重要信息(持久化)

Kubelet:直接跟容器引擎交互实现容器的生命周期管理

Kube- proxY:负责写入规则至 IPTABLES、IPVs实现服务映射访问的

COREDNS:可以为集群中的svC创建一个域名IP的对应关系解析

DASHBOARD:给K8S集群提供一个B/S结构访间体系

INGRESS CONTROLLER:官方只能实现四层代理, INGRESS可以实现七层代理

FEDERATION:提供一个可以跨集群中心多K8S统一管理功能

PROMETHEUS:提供K8s集群的监控能力

ELK:提供K8s集群日志统一分析介入平台









## 3、Pod

自主式 Pod & 控制器管理的 Pod

pause



Replication Controller用来确保容器应用的副本数始终保持在用户定义的副本数,即如果

有容器异常退出,会自动创建新的Pod来替代;而如果异常多出来的容器也会自动回收

在新版本的 Kubernetes中建议使用 ReplicaSe来取代 Replication Controlle

Replicase跟 Replication Controller没有本质的不同,只是名字不一样,并且

ReplicaSe支持集合式的 selector

虽然 ReplicaSe可以独立使用,但一般还是建议使用 Deployment来自动管理

ReplicaSe,这样就无需担心跟其他机制的不兼容问題(比如 ReplicaSe不支持

rolling-update但 Deployment支持)





















## 4、常用命令

```bash
kubectl get pods --all-namespaces | grep xtgl

kubectl delete pod basic-api-gateway-sv-deploy-6d94cc8998-7vkxt --grace-period=0 --force 


kubectl logs -f --tail=100 ih-auth-cbff885dc-64b7t
```







## 4、相关资料

概念总结：https://mp.weixin.qq.com/s/b2_4p644P5DYDzPk-3tMlA
