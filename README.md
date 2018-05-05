# 专业技术兵员精准动员实时指挥系统

**[图片路径](https://github.com/MBControlGroup/command-system/tree/master/design_docs)**

## 需求文档


[专业技术兵员精准动员实时指挥系统需求分析文档——腾讯文档](https://docs.qq.com/doc/BqI21X2yZIht10CYh118PMy61XMWSz0bstpX19oZGS19zfpI4 )

## 用例图

![用例图](./design_docs/usecase.png)

## 管理端原型

[管理端原型设计](https://2njuqd.axshare.com/#g=1&p=登录)

## 小程序端原型

[小程序端原型设计](https://modao.cc/app/9KNjMcOJs03gnrgyfRhmxdM7LAljs7Q)

## 数据库表

### 数据库表设计文档

[数据库表——腾讯文档](https://docs.qq.com/sheet/BqI21X2yZIht1OeHzN4IrNKM2LZciQ4P11Qd4rnIMT4aCLK84 )

### 表的关系图

**（注意！由于数据库表较多，下面每张图只展示了其对应功能模块直接相关的数据库表，但是表之间的关联仍然存在。）**

#### 人事管理

![org_architecture](./design_docs/db/org_architecture.png)

#### 任务管理

![task](./design_docs/db/task.png)

#### 消息管理

![notification](./design_docs/db/notification.png)

## 架构图

常用的功能作为核心服务开发。核心服务之上的是微服务。

![架构图](./design_docs/architecture.png)

## 服务器API设计

[服务器API设计草稿——腾讯文档](https://docs.qq.com/doc/BqI21X2yZIht1LMhNH4XCzrf144lFz2m6eW641MPyi0BOmg03)

[服务端 REST API设计](https://pmcs.docs.apiary.io/#)
