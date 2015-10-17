## CYPasswordView
---
`CYPasswordView`是一个模仿支付宝输入支付密码的密码框。
### 一、说明
---
* `CYPasswordView`是一个简单且实用的输入密码框
* 具体用法主要参考Demo程序

### 二、使用方法
---
1. 将`CYPasswordView`文件夹添加到项目中
2. 导入主头文件`#import "CYPasswordView.h"`

### 三、部分API的介绍
---
* 实例化`CYPasswordView`对象
``` objc
[[CYPasswordView alloc] init];
```
* 弹出密码框
``` objc
- (void)showInView:(UIView *)view;
```

* 密码输入完成的回调
``` objc
@property (nonatomic, copy) void (^finish) (NSString *password);
```
* 隐藏键盘
``` objc
- (void)hidenKeyboard;
```
* 隐藏密码框
``` objc
- (void)hide;
```
* 开始加载（发送网络请求时，加载动画）
``` objc
- (void)startLoading;
```

* 加载完成（暂停动画）
``` objc
- (void)stopLoading;
```

* 请求完成
``` objc
- (void)requestComplete:(BOOL)state;
- (void)requestComplete:(BOOL)state message:(NSString *)message;
```

* 设置对话框标题
``` objc
@property (nonatomic, copy) NSString *title;
```

### 四、效果示例
---
![CYPasswordView](https://github.com/chernyog/CYPasswordView/blob/master/CYPasswordViewDemo/CYPasswordViewDemo/CYPasswordViewDemo.gif "CYPasswordView示例")