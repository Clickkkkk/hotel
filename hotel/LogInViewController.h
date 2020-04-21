//
//  LogInViewController.h
//  hotel
//
//  Created by 周彦辰 on 12/24/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

//登录界面的控制器
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogInViewController : UIViewController

//声明控制器的两个属性，用来接受注册控制器的传值
@property (copy,nonatomic) NSString *usernameDidRegistered;
@property (copy,nonatomic) NSString *passportDidRegistered;

@end

NS_ASSUME_NONNULL_END
