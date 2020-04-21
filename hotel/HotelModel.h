//
//  HotelModel.h
//  hotel
//
//  Created by 周彦辰 on 12/29/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//


//模型！！
#import <Foundation/Foundation.h>
#import "func.h"

NS_ASSUME_NONNULL_BEGIN

@interface HotelModel : NSObject <NSSecureCoding>

//声明模型的各个属性
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *min_price;
@property (copy,nonatomic) NSString *max_price;
@property (copy,nonatomic) NSString *score;
@property (copy,nonatomic) NSString *adress;
@property (copy,nonatomic) NSString *inform;

//声明方法
//前两个封装了把结点内容转成模型的方法
- (instancetype) initWithHotelList:(HotelList*)L;
+ (instancetype) HotelModelWithHotelList:(HotelList*)L;
//这个封装了把模型转成HotelInfo结构的方法
- (HotelInfo) getHotelFromModel:(HotelModel *)model;

- (void)_archiviListDataWithArray:(NSArray<HotelModel *> *)array;

@end

NS_ASSUME_NONNULL_END
