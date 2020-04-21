//
//  HotelModel.m
//  hotel
//
//  Created by 周彦辰 on 12/29/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

#import "HotelModel.h"
#define FILE_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

@implementation HotelModel

+ (BOOL)supportsSecureCoding{
    return YES;
}

//实现这些方法（基本都在转格式。。）
- (instancetype)initWithHotelList:(HotelList *)L{
    self = [super init];
    if (self) {
        self.name = [[NSString alloc] initWithUTF8String:L->data.hotel_name];
        self.min_price = [NSString stringWithFormat:@"%d",L->data.hotel_min_price];
        self.max_price = [NSString stringWithFormat:@"%d",L->data.hotel_max_price];
        self.score = [NSString stringWithFormat:@"%.1lf",L->data.hotel_score];
        self.adress = [[NSString alloc] initWithUTF8String:L->data.hotel_address];
        self.inform = [[NSString alloc] initWithUTF8String:L->data.hotel_inform];
    }
    return self;
}

+ (instancetype) HotelModelWithHotelList:(HotelList*)L{
    return [[HotelModel alloc] initWithHotelList:L];
}

- (HotelInfo) getHotelFromModel:(HotelModel *)model{
    
    HotelInfo new;
    const char * p1 = [model.name UTF8String];strcpy(new.hotel_name, p1);
    new.hotel_min_price = [model.min_price intValue];
    new.hotel_max_price = [model.max_price intValue];
    new.hotel_score =[model.score doubleValue];
    const char * p2 = [model.adress UTF8String];strcpy(new.hotel_address, p2);
    const char * p3 = [model.inform UTF8String];strcpy(new.hotel_inform, p3);
    return new;
    
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_min_price forKey:@"min_price"];
    [coder encodeObject:_max_price forKey:@"max_price"];
    [coder encodeObject:_score forKey:@"score"];
    [coder encodeObject:_adress forKey:@"adress"];
    [coder encodeObject:_inform forKey:@"inform"];
}

//解码的属性
- (nullable instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super init]){
        _name = [coder decodeObjectForKey:@"name"];
        _min_price = [coder decodeObjectForKey:@"min_price"];
        _max_price = [coder decodeObjectForKey:@"max_price"];
        _score = [coder decodeObjectForKey:@"score"];
        _adress = [coder decodeObjectForKey:@"adress"];
        _inform = [coder decodeObjectForKey:@"inform"];
    }
    return self;
}

- (void)_archiviListDataWithArray:(NSArray<HotelModel *> *)array{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *dataPath = [FILE_PATH stringByAppendingPathComponent:@"List"];
//    [fm createDirectoryAtPath:dataPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSData *hotelData = [NSKeyedArchiver archivedDataWithRootObject:array requiringSecureCoding:YES error:nil];
    [fm createFileAtPath:dataPath contents:hotelData attributes:nil];
    
}

@end
