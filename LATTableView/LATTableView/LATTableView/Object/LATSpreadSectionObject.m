//
//  LATSectionObject.m
//  Later
//
//  Created by Later on 16/7/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "LATSpreadSectionObject.h"

@implementation LATSpreadSectionObject
- (NSInteger)rowCount {
   return self.isSpread ? self.rowObjects.count : 0;
}

@end
