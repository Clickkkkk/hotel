//
//  func.h
//  项目实践
//
//  Created by 周彦辰 on 12/26/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

#ifndef func_h
#define func_h

#include <stdbool.h>
//#include <stdio.h>
//#include <stdlib.h>
//#include <string.h>
#define MAX_NUMBER_LEN 100

#define MAX_NAME_LEN 50

#define MAX_ADDRESS_LEN 100

#define MAX_INFORM_LEN  1000

#define BUCKETSIZE 10

typedef struct {
char hotel_name[MAX_NAME_LEN];
int hotel_min_price;
int hotel_max_price;
double hotel_score;
char hotel_address[MAX_ADDRESS_LEN];
char hotel_inform[MAX_INFORM_LEN];
} HotelInfo;
struct List {
    int item;
    struct List* next;
};

struct Listhead {
    struct List* head;
};

typedef struct node{
HotelInfo data;
struct node *next;
} HotelList;

void welcome_one(void);
void welcome_two(void);
bool scan(HotelList **L,char *file_name);//加载到链表
void PrintHotel(HotelList* head);
HotelList* search(HotelList *L, char* hotel_name);//酒店名查找（还可用于修改，删除）
HotelList* arrange(HotelList *L);//按价格桶排序整理
HotelInfo add_new(void);//让用户输入新的酒店信息
void search_all(HotelList* L, char* hotel_name);
bool change_item(HotelList *L, char* hotel_number, HotelInfo new);//修改ok
bool insert(HotelList **L,HotelInfo new,int choice);//增加到尾部ok
bool delete_item(HotelList** L, char* hotel_name);//删除ok
bool save(HotelList **L,char *file_name);//新链表保存

#endif /* func_h */
