//
//  func.c
//  项目实践
//
//  Created by 周彦辰 on 12/26/19.
//  Copyright © 2019 周彦辰. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "func.h"

void welcome_one() {
    printf("*************************************\n");
    printf("*1.默认打印所有酒店                 *\n");
    printf("*2.搜索酒店（按名称）               *\n");
    printf("*3.价格降序打印酒店                 *\n");
    printf("*4.提供新的信息                     *\n");
    printf("*5.回到主界面                       *\n");
    printf("*************************************\n");

}

void welcome_two() {
    printf("*************************************\n");
    printf("*1.默认打印所有酒店                 *\n");
    printf("*2.搜索酒店（按名称）               *\n");
    printf("*3.价格降序打印酒店                 *\n");
    printf("*4.增加新的酒店                     *\n");
    printf("*5.删除已有酒店                     *\n");
    printf("*6.修改酒店信息                     *\n");
    printf("*7.保存                             *\n");
    printf("*8.回到主界面                       *\n");
    printf("*************************************\n");
}

HotelList* search(HotelList* L, char* hotel_name) {
    //    HotelList * p;
    for (; L != NULL; L = L->next) {
        if (strstr(L->data.hotel_name, hotel_name) != NULL)break;
    }
    if (L == NULL)
        return NULL;
    else
        return L;
}//寻找一个酒店

void search_all(HotelList* L, char* hotel_name) {
    //    HotelList* p;
    int i = 0;
    for (; L != NULL; L = L->next) {
        if (strstr(L->data.hotel_name, hotel_name) != NULL)
        {
            printf("Hotel's name:%s\n", L->data.hotel_name);
            printf("Hotel's min price:%d\n", L->data.hotel_min_price);
            printf("Hotel's max price:%d\n", L->data.hotel_max_price);
            printf("Hotel's score:%.1f\n",L->data.hotel_score);
            printf("Hotel's address:%s\n", L->data.hotel_address);
            printf("Hotel's information:%s\n", L->data.hotel_inform);
            i = i + 1;
        }
    }
    if (i == 0)printf("No such hotel");
}//找到所有包含搜索字节的酒店，并打印

HotelList* CreateChain(HotelList* head) {
    head = (HotelList*)malloc(sizeof(HotelList));
    if (head == NULL)
        exit(0);
    else
        head->next = NULL;
    return head;
}

HotelInfo add_new(void) {
    HotelInfo new;
    printf("New hotel's name:");
    scanf("%s", new.hotel_name);
    getchar();
    printf("New hotel's min price:");
    scanf("%d", &new.hotel_min_price);
    getchar();
    printf("New hotel's max price:");
    scanf("%d", &new.hotel_max_price);
    getchar();
    printf("New hotel's score:");
    scanf("%lf", &new.hotel_score);
    getchar();
    printf("New hotel's address:");
    scanf("%s\"", new.hotel_address);
    getchar();
    printf("New hotel's information:");
    scanf("%s", new.hotel_inform);
    getchar();
    return new;
}

void AddHotel(HotelList* head, HotelInfo info) {
    HotelList* p = NULL;

    p = (HotelList*)malloc(sizeof(HotelList));
    p->data = info;
    p->next = head->next;
    head->next = p;
}

int HotelNumber(HotelList* head) {
    int count = 0;
    HotelList* next = head->next;
    while (next)
    {
        count++;
        next = next->next;
    }
    return count;
}

void PrintHotel(HotelList* head) {
    HotelList* next = head;
    printf("Hotel's name:%s\n", next->data.hotel_name);
    printf("Hotel's min price:%d\n", next->data.hotel_min_price);
    printf("Hotel's max price:%d\n", next->data.hotel_max_price);
    printf("Hotel's  score:%.1f\n", next->data.hotel_score);
    printf("Hotel's address:%s\n", next->data.hotel_address);
    printf("Hotel's information:%s\n", next->data.hotel_inform);
    while (next->next)
    {
        next = next->next;
        printf("Hotel's name:%s\n", next->data.hotel_name);
        printf("Hotel's min price:%d\n", next->data.hotel_min_price);
        printf("Hotel's max price:%d\n", next->data.hotel_max_price);
        printf("Hotel's  score:%.1f\n", next->data.hotel_score);
        printf("Hotel's address:%s\n", next->data.hotel_address);
        printf("Hotel's information:%s\n", next->data.hotel_inform);
    }
}



void bucket_init(struct Listhead** buckets, int bucketsize) {
    int i;
    for (i = 0; i < bucketsize; i++) {
        buckets[i] = malloc(sizeof(struct Listhead));
        buckets[i]->head = NULL;
    }
}

void list_add(struct Listhead** buckets, int item, int position) {
    struct Listhead* list = buckets[position];
    struct List* new = malloc(sizeof(struct List));
    new->item = item;
    new->next = NULL;
    if (list->head) {
        struct List* current = list->head, * prev = NULL;
        while (current) {//»∑∂®Œª÷√
            if (current->item >= item) {
                new->next = current;
                if (prev) {
                    prev->next = new;
                }//±»µ⁄“ª∏ˆ¥Û
                else {
                    list->head = new;
                }//±»µ⁄“ª∏ˆ–°
                break;
            }
            prev = current;
            current = current->next;
        }
        if (prev)
            prev->next = new;
    }
    else
        list->head = new;
}

void bucket_add(struct Listhead** buckets, int item, int pos) {
    int num = item;
    for (; pos > 1; pos--) {
        num = num / 10;
    }
    num = num % 10;
    list_add(buckets, item, num);
}

void bucket_scan(struct Listhead** buckets, int* data, int bucketsize) {
    int sp = -1, i, nowvalue;
    struct List* list;
    for (i = 0; i < bucketsize; i++) {
        list = buckets[i]->head;
        while (list) {
            nowvalue = list->item;
            data[++sp] = nowvalue;
            list = list->next;
        }
    }
}

void bucketsort(int* data, int size, int pos) {
    struct Listhead* buckets[BUCKETSIZE];
    bucket_init(buckets, BUCKETSIZE);
    int i;
    for (i = 0; i < size; i++)
        bucket_add(buckets, data[i], pos);
    bucket_scan(buckets, data, BUCKETSIZE);
}

void all_sort(int* data, int size, int digitsize) {
    int i;
    for (i = 1; i <= digitsize; i++)
        bucketsort(data, size, i);
}

HotelList* arrange(HotelList* L) {
    int count, i;
    count = HotelNumber(L);
    int* data;
    HotelInfo* infos;
    HotelList* next;
    HotelList* head = NULL;
    head = CreateChain(head);
    infos = (HotelInfo*)malloc(count * sizeof(HotelInfo));
    data = (int*)malloc(count * sizeof(int));
    next = L->next;
    for (i = 0; i < count; i++) {
        *(data + i) = (next->data.hotel_min_price) * 100 + i;
        *(infos + i) = next->data;
        next = next->next;
    }
    all_sort(data, count, 5);
    for (i = 0; i < count; i++) {
//        printf("Hotel's name:%s\n", (infos + (*(data + i) % 100))->hotel_name);
//        printf("Hotel's min price:%d\n", (infos + (*(data + i) % 100))->hotel_min_price);
//        printf("Hotel's max price:%d\n", (infos + (*(data + i) % 100))->hotel_max_price);
//        printf("Hotel's score:%.1f\n", (infos + (*(data + i) % 100))->hotel_score);
//        printf("Hotel's address:%s\n", (infos + (*(data + i) % 100))->hotel_address);
//        printf("Hotel's information:%s\n", (infos + (*(data + i) % 100))->hotel_inform);
        //°¬?®C?°¬?°Æ??£§°¿®¨
        AddHotel(head, *(infos + (*(data + i) % 100)));
    }
    return head;
}//∞¥º€∏ÒÕ∞≈≈–Ú’˚¿Ì


bool insert(HotelList** L, HotelInfo new, int choice) {//L指向头节点
    HotelList* newHotel, * p = NULL;
    int i = 0;

    newHotel = (HotelList*)malloc(sizeof(HotelList));
    if (!newHotel) {
        printf("Error.\n");
        return false;
    }
    newHotel->data = new;
    switch (choice) {
    case 1://插入头部
        if ((*L) == NULL) {
            (*L)=(HotelList*)malloc(sizeof(HotelList));
            (*L)->data = new;
            (*L)->next = NULL;
        }
        else {
            newHotel->next = *L;
            //newHotel = *L;
            (*L) = newHotel;
        }
        return true;
    case 0://插入尾部
        p = *L;
        while (p->next) {
            p = p->next;
        }
        p->next = newHotel;
        newHotel->next = NULL;
        return true;
    default://插入到指定节点
        p = *L;
        for (; i < choice - 1; i++) {
            p = p->next;
        }
        newHotel->next = p->next;
        p->next = newHotel;
        return true;
    }
}//插入到指定节点

bool delete_item(HotelList** L, char* hotel_name) {
    HotelList* cur,*prev;
    for (cur = (*L), prev = NULL;
        cur != NULL;
        prev = cur, cur = cur->next) {
        if(strstr(cur->data.hotel_name, hotel_name) != NULL)break;
    }

    if (!cur)
        return false;//没找着
    if (!prev)
        (*L) = (*L)->next;//在第一个
    else
        prev->next = cur->next;//找着了，并且不在第一个
    return true;
}//删除

bool change_item(HotelList* L, char* hotel_name, HotelInfo new) {
    HotelList* p = search(L, hotel_name);
    if (p) {
        p->data = new;
        return true;
    }
    else
        return false;
}//修改

bool scan(HotelList** L, char* file_name) {

    FILE* fp = fopen(file_name, "a+");
    //fseek(fp, 50L, SEEK_SET);       //从第二行开始读取
    fseek(fp, 0, SEEK_SET);
    if (!fp)
    {
        perror("fopen");
        exit(EXIT_FAILURE);
    }
    HotelInfo hotelInfoNew;
    //while (fscanf(fp, " %s%d %d %lf %s%s", hotelInfoNew.hotel_name, &hotelInfoNew.hotel_min_price, &hotelInfoNew.hotel_max_price, &hotelInfoNew.hotel_score, hotelInfoNew.hotel_address, hotelInfoNew.hotel_inform)!=EOF)
    while(!feof(fp))
    {
        
        fscanf(fp, "%[^1-9]", hotelInfoNew.hotel_name);
        fscanf(fp, "%d", &hotelInfoNew.hotel_min_price);
        fscanf(fp, "%d", &hotelInfoNew.hotel_max_price);
        fscanf(fp, "%lf", &hotelInfoNew.hotel_score);
        fscanf(fp, "%[^\"]",hotelInfoNew.hotel_address);
        fscanf(fp, "%[^\n]",hotelInfoNew.hotel_inform);
        fgetc(fp);
        //数据从文件放到链表里面
        insert(L, hotelInfoNew, 1);
    }

    fclose(fp);

    return 0;
}

bool save(HotelList** L, char* file_name) {
    FILE* fp1 = fopen(file_name, "w");
    HotelList* p =*L;
    p->next = (*L)->next;
    
    //fprintf(fp1, "name\t\t\t max price\t min price\t score\t address\t\t information\n");
    while (p->next) {
        fwrite(p->data.hotel_name, 1, strlen(p->data.hotel_name), fp1);
        //fwrite("\t\t\t", 1, 3, fp1);
        fprintf(fp1, "%d\t", p->data.hotel_max_price);
        fprintf(fp1, "%d\t",p->data.hotel_min_price);
        fprintf(fp1, "%.1f\t",p->data.hotel_score);
        fwrite(p->data.hotel_address, 1, strlen(p->data.hotel_address), fp1);
        //fwrite("\t\t", 1, 3, fp1);
        fwrite(p->data.hotel_inform, 1, strlen(p->data.hotel_inform), fp1);
        //fwrite("\r\n", 1, 3, fp1);
        p= p->next;
    }
    
    fclose(fp1);
    return true;

}
