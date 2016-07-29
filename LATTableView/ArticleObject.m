//
//  RowObject.m
//  LATTableView
//
//  Created by Later on 16/7/29.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "ArticleObject.h"

@implementation ArticleObject
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
