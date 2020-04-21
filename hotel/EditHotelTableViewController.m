//
//  EditHotelTableViewController.m
//  hotel
//
//  Created by 周彦辰 on 12/29/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

#import "EditHotelTableViewController.h"
#import "func.h"

//在添加控制器中声明文本框属性和保存按钮属性
@interface EditHotelTableViewController ()<UITextFieldDelegate>

//在添加控制器中声明文本框属性和保存按钮属性
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *minPrice;
@property (weak, nonatomic) IBOutlet UITextField *maxPrice;
@property (weak, nonatomic) IBOutlet UITextField *score;
@property (weak, nonatomic) IBOutlet UITextView *adress;
@property (weak, nonatomic) IBOutlet UITextView *inform;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation EditHotelTableViewController

//监听所有文本框和按钮
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //监听所有文本框的变化，当文本框的内容被编辑时，调用textChange方法
    [self.name addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    self.name.delegate = self;
    [self.minPrice addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    self.minPrice.delegate = self;
    [self.maxPrice addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    self.maxPrice.delegate = self;
    [self.score addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    self.score.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.adress];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.inform];

    //监听保存按钮点击事件 被点击时调用saveClick方法
    [self.saveButton addTarget:self action:@selector(saveClick) forControlEvents: UIControlEventTouchUpInside];
}

//监听到所有文本框都有内容，保存按钮允许使用
- (void) textChange{
    self.saveButton.enabled = self.name.text.length > 0     &&
                              self.minPrice.text.length > 0 &&
                              self.maxPrice.text.length > 0 &&
                              self.score.text.length > 0    &&
                              self.adress.text.length > 0   &&
                              self.inform.text.length > 0 ;
}

//释放通知
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//保存按钮的点击事件，如果酒店列表控制器响应了代理方法，把各个文本框的值包装成模型传回去
- (void) saveClick{
    
    if([self.delegate respondsToSelector:@selector(editHotelTableViewController:withHotelModel:)]){
        //如果酒店列表控制器响应了代理方法，把各个文本框的值包装成模型传回去
        HotelModel *model = [[HotelModel alloc] init];
        model.name = self.name.text;
        model.min_price = self.minPrice.text;
        model.max_price = self.maxPrice.text;
        model.score = self.score.text;
        model.adress = self.adress.text;
        model.inform = self.inform.text;
        [self.delegate editHotelTableViewController:self withHotelModel:model];
    }
        //返回上一个控制器（指酒店列表控制器）
        [self.navigationController popViewControllerAnimated:YES];
    
}

/*
//textView自适应高度
//- (void)textViewDidChange:(UITextView *)textView;
//    CGSize size=[textview sizeThatFits:CGSizeMake(CGRectGetWidth(textview.frame), MAXFLOAT)];
//    CGRect frame=textview.frame;
//    frame.size.height=size.height;
//    textview.frame=frame;
//}
*/

@end
