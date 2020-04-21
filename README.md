
# 成都酒店信息管理系统


原型是大一上期末C语言用链表完成的大作业，改进后完善了界面与逻辑。<br>
#### 几个要点：<br>

* 数据持久化，目前使用的是NSKeyedArchiver，使用序列化与反序列化的方式在酒店对象与NSData二进制数据之间转换，因此HotelModel必须遵守\<NSSecureCoding>协议。（iOS12以前是遵守\<NSCoding>协议）
* 使用单例对象NSUserDefaults存储用户偏好，这里用来储存记住的用户名和密码以及登录模式
* 获取沙盒路径的方式以及NSManager和NSFileHandle的文件操作

#### 目前功能：<br>

* 注册与登录，账号会自动保存，若打开了记住密码，密码将在登录成功后保存
<img src="http://img03.sogoucdn.com/app/a/100520146/f0d514ad36d4569b5996e4419554186c" width="525" height="502" />
* 展示酒店列表，点击进入详情页面，图片可以放大看
<img src="http://img02.sogoucdn.com/app/a/100520146/b581e2274b3641e11bc06987842626f5" width="787" height="450" />
