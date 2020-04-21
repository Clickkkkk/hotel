//
//  LogInViewController.m
//  hotel
//
//  Created by 周彦辰 on 12/24/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

#import "LogInViewController.h"
#import "HotelTableViewController.h"
#import "ResgisterViewController.h"

@interface LogInViewController () <UITextFieldDelegate,ResgisterViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passportField;
@property (weak, nonatomic) IBOutlet UIButton *loginbutton;
@property (weak, nonatomic) IBOutlet UISwitch *remember;
@property (weak, nonatomic) IBOutlet UISwitch *manager;


@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usernameField.delegate = self;
    
    //根据偏好设置恢复用户名和密码
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.usernameField.text = [ud objectForKey:@"username"];
    if ([ud boolForKey:@"remenberIsOn"])
        self.passportField.text = [ud objectForKey:@"password"];
    
    
    //监听文本框
    [self.usernameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.passportField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    //监听登录按钮
    [self.loginbutton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    //监听开关
//    [self.remember addTarget:self action:@selector(remember) forControlEvents:UIControlEventValueChanged];
//    [self.manager addTarget:self action:@selector(manager) forControlEvents:UIControlEventValueChanged];
    
    NSString *home = [NSString stringWithFormat:@"%@",NSHomeDirectory()];
    NSLog(@"home--%@",home);
    NSArray *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = documentsPath[0];
    NSLog(@"doc--%@",docPath);
    
    //恢复开关状态
    self.remember.on = [ud boolForKey:@"remenberIsOn"];
    self.manager.on = [ud boolForKey:@"managerIsOn"];
    
    [self textChange];
    
}

//文本框被编辑时调用，若两文本框内容长度均大于0，登录按钮允许使用
- (void)textChange{
    self.loginbutton.enabled = self.usernameField.text.length > 0 && self.passportField.text.length > 0;
}

//登录按钮点击事件，判断账户名和密码是否正确，正确时执行跳转
- (void)login{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //如果用户名和密码都是1，执行跳转
        if (([self.usernameField.text isEqualToString:@"1"] && [self.passportField.text isEqualToString:@"1"])||
            ([self.usernameField.text isEqualToString:self.usernameDidRegistered] && [self.passportField.text isEqualToString:self.passportDidRegistered]))
            //跳转
            [self performSegueWithIdentifier:@"toHotelList" sender:nil];
            //如果记住密码开关是开的，将按钮状态保存在偏好设置中
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setBool:self.remember.isOn forKey:@"remenberIsOn"];
            [ud setBool:self.manager.isOn forKey:@"managerIsOn"];
            [ud setObject:self.usernameField.text forKey:@"username"];
            [ud setObject:self.passportField.text forKey:@"password"];
            
    });
    
}

//是否允许文本框进行编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField; {
    return YES;
}

//成为第一响应者 文本框已经开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
}

//是否允许文本框结束编辑
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}



//判断目标控制器是否是注册控制器，如果是，让登录控制器成为代理接受注册控制器的传值
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc = segue.destinationViewController;
    if ([vc isKindOfClass:[ResgisterViewController class]]){
        //判断目标控制器是否是注册控制器，如果是，让登录控制器成为代理接受注册控制器的传值
        ResgisterViewController *res = (ResgisterViewController *)vc;
        res.delegate = self;
        NSLog(@"注册代理在这儿");
    }else{
    }
}

//注册控制器的代理方法，用注册控制器两文本框的内容直接给登录控制器的usernameDidRegistered和
//passportDidRegistered属性赋值
- (void)resgisterViewControllerDelegate:(ResgisterViewController *)resgisterViewController withUserName:(NSString *)username AndPassport:(NSString *)passport{
    
    _usernameDidRegistered = [[NSString alloc] initWithFormat:@"%@", username];
    _passportDidRegistered = [[NSString alloc] initWithFormat:@"%@", passport];
}

/*
//文本框已经结束编辑
//- (void)textFieldDidEndEditing:(UITextField *)textField{}

//
//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason API_AVAILABLE(ios(10.0)); // if implemented, called in place of textFieldDidEndEditing{}

//返回0时文本框不可改变
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{}

//
//- (void)textFieldDidChangeSelection:(UITextField *)textField API_AVAILABLE(ios(13.0), tvos(13.0));
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.
*/

//给HotelList控制器设置unwind Segue用的
- (IBAction)unwindToLogInMenu:(UIStoryboardSegue*)sender
{
//    UIViewController *sourceViewController = sender.sourceViewController;
    // Pull any data from the view controller which initiated the unwind segue.
}


@end
