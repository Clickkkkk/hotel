//
//  HotelTableViewCell.h
//  hotel
//
//  Created by 周彦辰 on 12/29/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

//自定义的单元格，不用管这两个文件
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HotelModel;

@interface HotelTableViewCell : UITableViewCell

@property (strong, nonatomic) HotelModel *model;
@end

NS_ASSUME_NONNULL_END
