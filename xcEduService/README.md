# xcEduService

#### 项目介绍
博学谷学成在线课程代码

#### 软件架构
学成在线服务端基于Spring Boot构建，采用Spring Cloud微服务框架。
持久层：MySQL、MongoDB、Redis、ElasticSearch 数据访问层：使用Spring Data JPA 、Mybatis、Spring Data Mongodb等
业务层：Spring IOC、Aop事务控制、Spring Task任务调度、Feign、Ribbon、Spring AMQP、Spring Data Redis 等。
控制层：Spring MVC、FastJSON、RestTemplate、Spring Security Oauth2+JWT等 微服务治理：Eureka、Zuul、Hystrix、Spring Cloud Conﬁg等

#####用到的技术
1.spring cloud
2.spring boot
3.zuul
4.eureka
5.rabbitMQ
6.spring data
7.mongodb

######常见的springcloud 微服务架构:

1.所有model在一个工程,所有api在一个工程,api依赖model service和client依赖api
2.每个模块有自己的api工程,model和api放在一个工程里service和client依赖api

本项目用的是方案一

#### 安装教程

1. xxxx
2. xxxx
3. xxxx

#### 使用说明

1. xxxx
2. xxxx
3. xxxx

#### 参与贡献

1. Fork 本项目
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request


#### 码云特技

1. 使用 Readme\_XXX.md 来支持不同的语言，例如 Readme\_en.md, Readme\_zh.md
2. 码云官方博客 [blog.gitee.com](https://blog.gitee.com)
3. 你可以 [https://gitee.com/explore](https://gitee.com/explore) 这个地址来了解码云上的优秀开源项目
4. [GVP](https://gitee.com/gvp) 全称是码云最有价值开源项目，是码云综合评定出的优秀开源项目
5. 码云官方提供的使用手册 [https://gitee.com/help](https://gitee.com/help)
6. 码云封面人物是一档用来展示码云会员风采的栏目 [https://gitee.com/gitee-stars/](https://gitee.com/gitee-stars/)