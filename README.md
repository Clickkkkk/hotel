
# 成都酒店信息管理系统


原型是大一上期末C语言用链表完成的大作业，改进后完善了界面与逻辑。<br>
#### 几个要点：<br>

* 数据持久化，目前使用的是NSKeyedArchiver，序列化与反序列化的方式在酒店对象与NSData二进制之间转换，因此HotelModel必须遵守<NSSecureCoding>协议。<br>iOS12以前是<NSCoding>
* 使用单例对象NSUserDefaults存储用户偏好，这里用来储存记住的用户名和密码以及登录模式
* 
