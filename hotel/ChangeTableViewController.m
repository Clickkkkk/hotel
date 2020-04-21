//
//  ChangeTableViewController.m
//  hotel
//
//  Created by 周彦辰 on 12/29/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

#import "ChangeTableViewController.h"

//声明编辑控制器的各个文本框的按钮属性
@interface ChangeTableViewController ()

//声明编辑控制器的各个文本框的按钮属性
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *minPriceField;
@property (weak, nonatomic) IBOutlet UITextField *maxPriceField;
@property (weak, nonatomic) IBOutlet UITextField *scoreField;
@property (weak, nonatomic) IBOutlet UITextView *adressView;
@property (weak, nonatomic) IBOutlet UIButton *btn666;
@property (weak, nonatomic) IBOutlet UITextView *informView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong,nonatomic) UIButton *bgImg;
- (IBAction)iconBtnClick:(id)sender;
- (void)back;
@end

@implementation ChangeTableViewController

- (IBAction)nameField:(UITextField *)sender {
}

//编辑按钮点击事件，被点击是按钮的字改变，各文本框允许编辑（再次点击不允许编辑）
- (IBAction)editClick:(UIBarButtonItem *)sender {
    if (self.saveButton.hidden){
        sender.title = @"取消";
        self.nameField.enabled = YES;
        self.minPriceField.enabled = YES;
        self.maxPriceField.enabled = YES;
        self.scoreField.enabled = YES;
        self.adressView.editable = YES;
        self.informView.editable = YES;
        self.saveButton.hidden = NO;
        self.btn666.enabled = NO;
    }else{
        sender.title = @"编辑";
        self.nameField.enabled = NO;
        self.minPriceField.enabled = NO;
        self.maxPriceField.enabled = NO;
        self.scoreField.enabled = NO;
        self.adressView.editable = NO;
        self.informView.editable = NO;
        self.saveButton.hidden = YES;
        self.btn666.enabled = YES;
    }
    
}

//用传来的模型给各文本框内容赋值
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImg=[[UIButton alloc]init];
    [self.bgImg setFrame:self.view.bounds];
    self.bgImg.backgroundColor=[UIColor cyanColor];
    self.bgImg.alpha=0;
    [self.bgImg addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.icon.image = [UIImage imageNamed:self.model.name];
    //用传来的模型给各文本框内容赋值
    self.nameField.text = self.model.name;
    self.minPriceField.text = self.model.min_price;
    self.maxPriceField.text = self.model.max_price;
    self.scoreField.text = self.model.score;
    self.adressView.text = self.model.adress;
    self.informView.text = self.model.inform;
    
    //监听保存按钮的点击事件
    [self.saveButton addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
}

//监听到保存按钮点击时调用方法：用文本框内容刷新模型里的数据，如果酒店列表控制器响应了代理方法，包装成模型扔回去
- (void)saveClick{
    
    //用文本框内容刷新模型里的数据
    self.model.name = self.nameField.text;
    self.model.min_price = self.minPriceField.text;
    self.model.max_price = self.maxPriceField.text;
    self.model.score = self.scoreField.text;
    self.model.adress = self.adressView.text;
    self.model.inform = self.informView.text;
    if ([self.delegate respondsToSelector:@selector(changeTableViewControllerDelegate:withHotelModel:)]){
        //如果酒店列表控制器响应了代理方法，包装成模型扔回去
        HotelModel *model = [[HotelModel alloc]init];
        model.name = self.nameField.text;
        model.min_price = self.minPriceField.text;
        model.max_price = self.maxPriceField.text;
        model.score = self.scoreField.text;
        model.adress = self.adressView.text;
        model.inform = self.informView.text;
        [self.delegate changeTableViewControllerDelegate:self withHotelModel:model];
    }
    //返回到上一个页面
    [self.navigationController popViewControllerAnimated:YES];
}//执行代理

//点击图片时触发，将图片添加到上一层视图
- (IBAction)iconBtnClick:(id)sender {
    [self.view addSubview:self.bgImg];
    [self.view addSubview:self.icon];
    [UIView animateWithDuration:1 animations:^{
        self.bgImg.alpha=0.5;
         [self.icon setFrame:CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.width*0.7, self.view.frame.size.width, self.view.frame.size.width)];
    }];
   
    
}

- (void)back{
    [self.bgImg removeFromSuperview];
    [UIView animateWithDuration:1 animations:^{
        self.bgImg.alpha=0.5;
         [self.icon setFrame:self.btn666.frame];
    }];
    
}

@end
