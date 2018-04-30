# 专业技术兵员精准动员实时指挥系统

**图片**可在`/design_docs`中看到

## 需求文档

腾讯文档：
https://docs.qq.com/doc/BqI21X2yZIht10CYh118PMy61XMWSz0bstpX19oZGS19zfpI4 

## 用例图

![用例图](https://raw.githubusercontent.com/MBControlGroup/command-system/master/design_docs/usecase.png)

## 管理端原型

https://2njuqd.axshare.com/#g=1&p=登录

## 小程序端原型

https://modao.cc/app/9KNjMcOJs03gnrgyfRhmxdM7LAljs7Q

## 数据库表

数据库表链接：
https://docs.qq.com/sheet/BqI21X2yZIht1OeHzN4IrNKM2LZciQ4P11Qd4rnIMT4aCLK84 

表的关系图：

### 人事管理

![](./design_docs/db/org_architecture.png)

### 任务管理

![](./design_docs/db/task.png)

### 消息管理

![](./design_docs/db/notification.png)

## 架构图

常用的功能作为核心服务开发。核心服务之上的是微服务。

![架构图](https://raw.githubusercontent.com/MBControlGroup/command-system/master/design_docs/architecture.png)

## 服务器API设计

https://docs.qq.com/doc/BqI21X2yZIht1LMhNH4XCzrf144lFz2m6eW641MPyi0BOmg03