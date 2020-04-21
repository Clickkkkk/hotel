//
//  HotelTableViewController.m
//  hotel
//
//  Created by 周彦辰 on 12/26/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

#import "HotelTableViewController.h"
#import "EditHotelTableViewController.h"
#import "HotelTableViewCell.h"
#import "ChangeTableViewController.h"
#import "HotelModel.h"
#define FILE_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//声明可变数列，用来储存酒店模型
@interface HotelTableViewController () <EditHotelTableViewControllerDelegate,ChangeTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *seg;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *add;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dataArray2;
@property (nonatomic, strong) NSMutableArray *dataArray3;

@end

@implementation HotelTableViewController

HotelList *head;
HotelList *headPrice;
char* file_name_read = "/Users/tongxi/Documents/SupportingFile/hotels.txt";
char* file_name_write = "/Users/tongxi/Documents/SupportingFile/19066print_test.txt";
BOOL segSelect = NO;

//懒加载数列
- (NSMutableArray *)dataArray{
    if (_dataArray == nil){
//        _dataArray = [NSMutableArray array];
//        scan(&head, file_name_read);//初始化链表
//        HotelList *L;
//        L = head;
//        while (L->next){
//            //调用HotelModel.h里声明的方法把每个结点的内容转成模型
//            HotelModel *model = [HotelModel HotelModelWithHotelList:L];
//            //移向下一个结点
//            L=L->next;
//            //把模型加进用来加载表格的数列中
//            [_dataArray addObject:model];
//        }
        //反序列化
        NSFileManager *fm = [NSFileManager defaultManager];
        NSString *filePath = [FILE_PATH stringByAppendingPathComponent:@"List"];
        if ([fm fileExistsAtPath:filePath]){
        //把文件里的二进制数据读进来
            NSData *readData = [fm contentsAtPath:filePath];
            _dataArray = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithObjects:[HotelModel class], [NSArray class], nil] fromData:readData error:nil];
        }else{
            [fm createFileAtPath:filePath contents:nil attributes:nil];
        }
    }
    return _dataArray;
}

//懒加载另一个可变数列，储存排序后的链表
- (NSMutableArray *)dataArray2{
    if (_dataArray2 == nil){
        _dataArray2 = [NSMutableArray array];
        scan(&headPrice, file_name_read);
        HotelList *L;
        L = arrange(headPrice);
        while (L->next){
            HotelModel *model = [HotelModel HotelModelWithHotelList:L];
            L=L->next;
            [_dataArray2 addObject:model];
        }
    }
    return _dataArray2;
}

- (NSMutableArray *)dataArray3{
    if (_dataArray3 == nil){
        _dataArray3 = [NSMutableArray array];
        HotelList *L;
        scan(&head, file_name_read);
        L = head;
        while (L->next){
            HotelModel *model = [HotelModel HotelModelWithHotelList:L];
            L=L->next;
            [_dataArray3 addObject:model];
        }
    }
    return _dataArray3;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    //加载数列
    [self dataArray];
//    [self.dataArray writeToFile:@"/Users/tongxi/Documents/code/hotel/hotel/xixixi.plist" atomically:NO];
    [self dataArray2];
    [self dataArray3];
    
    //添加左上角注销的按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    self.navigationItem.leftBarButtonItem = item;
    
    //去除空白行
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //监听到选择控件的值被改变时，比如点击了“按价格”，调用selectWith方法刷新表格
     [self.seg addTarget:self action:@selector(selectWith) forControlEvents:UIControlEventValueChanged];
    
    //非管理员模式，添加功能不可用
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud boolForKey:@"managerIsOn"]){
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(toEditController)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    
}

//把dataArray转换成NSData保存起来
- (void)_archiviListDataWithArray:(NSArray<HotelModel *> *)array{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *dataPath = [FILE_PATH stringByAppendingPathComponent:@"List"];
    
    NSData *hotelData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    [fm createFileAtPath:dataPath contents:hotelData attributes:nil];
}

//监听到选择空间的值发生改变时调用，用于刷新表格
-(void)selectWith{
    if (self.seg.selectedSegmentIndex == 0){
        segSelect = NO;
        [_dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:self.dataArray3];
        [self.tableView reloadData];
    }else{
        segSelect = YES;
        [_dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:self.dataArray2];
        [self.tableView reloadData];
    }
}

//监听到注销按钮点击时调用，弹出ActionSheet根据用户选择返回登录控制器
- (void)logOut{
    //UIAlertView风格
//    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
//                                   message:@"This is an alert."
//                                   preferredStyle:UIAlertControllerStyleAlert];

    //UIActionSheet风格
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确定注销？"
                                   message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* destructiveBtn = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        //销毁按钮的点击事件
//        [self performSegueWithIdentifier:@"toLogInVC" sender:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction: destructiveBtn];
        
    //添加默认按钮
    /*
    UIAlertAction* defaultBtn = [UIAlertAction actionWithTitle:@"常规按钮" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"UIAlertActionStyleDefault");
    }];
    [alert addAction:defaultBtn];
     */
    
    //添加取消按钮
    UIAlertAction* cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        NSLog(@"UIAlertActionStyleCancel");
    }];
    [alert addAction:cancelBtn];
    
    //把ActionSheet显示出来
    [self presentViewController:alert animated:YES completion:nil];
}

//告诉控制器某一组的表格有多少行（这里只有一个组）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)self.dataArray.count);
    return _dataArray.count;
}

//返回单元格的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"HotelCellID";
    //从缓存池中获取单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //用数列里的内容给单元格赋值
    cell.textLabel.text = [self.dataArray[indexPath.row] name];
//    NSLog(@"%lu###%lu#####%@",indexPath.section,indexPath.row,cell.textLabel.text);
    return cell;
}

//令tableView进入编辑模式，实现滑动删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self _archiviListDataWithArray:self.dataArray];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:3];
}


- (IBAction)unwindToHotelList:(UIStoryboardSegue*)sender
{
//    UIViewController *sourceViewController = sender.sourceViewController;
    // Pull any data from the view controller which initiated the unwind segue.
}

- (IBAction)unwindToHotelListFromEdit:(UIStoryboardSegue*)sender
{
//    UIViewController *sourceViewController = sender.sourceViewController;
    // Pull any data from the view controller which initiated the unwind segue.
}

- (void)toEditController{
    [self performSegueWithIdentifier:@"toEditController" sender:nil];
}

//使用segue时调用的方法，接受传值或给其他控制器传值
- (void)prepareForSegue :(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc = segue.destinationViewController;
    //判断传来的是哪个控制器
    if ([vc isKindOfClass:[EditHotelTableViewController class]]){
        //如果是添加控制器，设置代理接受x传值
        EditHotelTableViewController *edit = (EditHotelTableViewController *)vc;
        edit.delegate = self;
    }else{
        ChangeTableViewController *change = (ChangeTableViewController *)vc;
        //如果是编辑控制器，设置代理
        change.delegate = self;
        //获取点击 cell 的位置
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        //从dataArray中获取模型，传给编辑控制器显示出来
        change.model = self.dataArray[path.row];
    }
}

//实现添加控制器的代理方法（这里传来了一个新的模型）
- (void)editHotelTableViewController:(EditHotelTableViewController *)editHotelTableViewController withHotelModel:(HotelModel *)model{
    //把新的模型加进用来加载表格的数列中
    [_dataArray addObject:model];
    //调用HotelModel.h中声明的方法将新的模型转成HotelInfo结构
    HotelInfo new = [model getHotelFromModel:model];
    //把新的结构插进链表中
    if(insert(&head, new, 0))
        NSLog(@"insert 成功");
    //刷新表格
    [self.tableView reloadData];
    //让表视图滚动到最后一行
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.dataArray.count -1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self _archiviListDataWithArray:self.dataArray];
}


//实现编辑控制器的代理方法（这里传来了一个编辑过的模型）
- (void)changeTableViewControllerDelegate:(ChangeTableViewController *)changeTableViewController withHotelModel:(HotelModel *)model{
    //调用HotelModel.h中声明的方法将新的模型转成HotelInfo结构
    HotelInfo new = [model getHotelFromModel:model];
    insert(&head, new, 0);
    //改变对应结点
    if(change_item(head, new.hotel_name, new)){
        NSLog(@"change 成功");
        save(&head, file_name_write);
    }
    //根据新的模型刷新表格
    [self.tableView reloadData];
    //保存修改过的酒店列表
    [self _archiviListDataWithArray:self.dataArray];
}

@end

