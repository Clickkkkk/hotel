//
//  ResgisterViewController.h
//  hotel
//
//  Created by 周彦辰 on 12/29/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

//注册界面的控制器
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ResgisterViewController;

//声明代理方法，用来给登录控制器传值
@protocol ResgisterViewControllerDelegate <NSObject>

@optional

- (void)resgisterViewControllerDelegate:(ResgisterViewController*)resgisterViewController withUserName:(NSString*)username AndPassport:(NSString*)passport;

@end

@interface ResgisterViewController : UIViewController

@property (weak, nonatomic) id<ResgisterViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
