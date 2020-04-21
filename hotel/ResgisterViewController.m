//
//  ResgisterViewController.m
//  hotel
//
//  Created by 周彦辰 on 12/29/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

#import "ResgisterViewController.h"

//为控制器声明文本框属性
@interface ResgisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passportField;
@property (weak, nonatomic) IBOutlet UIButton *resgButton;

@end

@implementation ResgisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //监听文本框 当文本框内容被编辑时，调用textChange方法
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.passportField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    //监听点击事件 注册按钮点击时，调用resgButtonClick方法
    [self.resgButton addTarget:self action:@selector(resgButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

//监听到两文本框内容长度都>0时，注册按钮允许点击
- (void)textChange{
    self.resgButton.enabled = self.nameField.text.length > 0 && self.passportField.text.length > 0;
}

//注册按钮监听到点击事件时实现的方法：给上一个控制器传值
- (void)resgButtonClick{
    if([self.delegate respondsToSelector:@selector(resgisterViewControllerDelegate:withUserName:AndPassport:)]){
        //如果登录控制器相应了代理方法，进行传值。这里将两文本框的内容传过去了
        [self.delegate resgisterViewControllerDelegate:self withUserName:self.nameField.text AndPassport:self.passportField.text];
    }
    //返回到上一个控制器（即登录控制器）
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
