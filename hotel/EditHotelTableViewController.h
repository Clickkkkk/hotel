//
//  EditHotelTableViewController.h
//  hotel
//
//  Created by 周彦辰 on 12/29/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

//添加控制器
#import <UIKit/UIKit.h>
#import "HotelModel.h"


NS_ASSUME_NONNULL_BEGIN

@class EditHotelTableViewController;

//声明代理方法，用来给酒店列表控制器传值
@protocol EditHotelTableViewControllerDelegate <NSObject>

@optional

- (void) editHotelTableViewController:(EditHotelTableViewController *)editHotelTableViewController withHotelModel:(HotelModel *)model;
@end

@interface EditHotelTableViewController : UITableViewController

@property(weak,nonatomic)id<EditHotelTableViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
