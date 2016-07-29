//
//  LATTableViewSectionObject.h
//  Later
//
//  Created by Later on 16/7/29.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LATTableViewCellObject.h"
#import "LATTableViewHeaderObject.h"
#import "LATTableViewFooterObject.h"

@interface LATTableViewSectionObject : NSObject
@property (strong, nonatomic) NSMutableArray <LATTableViewCellObject *>* rowObjects;
@property (assign, nonatomic) NSInteger rowCount;

@property (strong, nonatomic) LATTableViewHeaderObject *headerObject;
@property (assign, nonatomic) NSInteger section;

@property (strong, nonatomic) LATTableViewFooterObject *footerObject;


@end
