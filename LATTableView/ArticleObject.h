//
//  RowObject.h
//  LATTableView
//
//  Created by Later on 16/7/29.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "LATTableViewCellObject.h"

@interface ArticleObject : LATTableViewCellObject
@property (copy, nonatomic) NSString *author;
@property (copy, nonatomic) NSString *brief;
@property (copy, nonatomic) NSString *create_time;
@property (copy, nonatomic) NSString *headpic;
@property (copy, nonatomic) NSString *id;
@property (copy, nonatomic) NSString *raw_headpic;
@property (copy, nonatomic) NSString *read_num;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *update_time;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *wechat_url;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
