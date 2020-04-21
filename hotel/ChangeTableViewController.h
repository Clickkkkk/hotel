//
//  ChangeTableViewController.h
//  hotel
//
//  Created by 周彦辰 on 12/29/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

//编辑控制器
#import <UIKit/UIKit.h>
#import "HotelModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ChangeTableViewController;

//声明编辑控制器的代理方法，用来给酒店列表控制器传值
@protocol ChangeTableViewControllerDelegate <NSObject>

@optional
//声明编辑控制器的代理方法，用来给酒店列表控制器传值
- (void)changeTableViewControllerDelegate:(ChangeTableViewController *)changeTableViewController withHotelModel:(HotelModel *)model;

@end

@class HotelModel;


@interface ChangeTableViewController : UITableViewController

@property (strong, nonatomic) HotelModel *model;
@property (weak, nonatomic) id<ChangeTableViewControllerDelegate> delegate;

@end



NS_ASSUME_NONNULL_END
