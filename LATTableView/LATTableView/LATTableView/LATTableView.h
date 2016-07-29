//
//  LATSpreadTableView.h
//  Later
//
//  Created by Later on 16/7/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LATTableViewSectionObject;
@interface LATTableView : UITableView
@property (strong, nonatomic) NSMutableArray <LATTableViewSectionObject *>*sectionObjects;
@property (copy, nonatomic) BOOL (^LATSpreadTableViewCellDidSelectedBlock)(LATTableView *,NSIndexPath *, id rowObject);
@property (copy, nonatomic) void (^LATSpreadTableViewHeaderView)(UITableViewHeaderFooterView *headeView);
@property (copy, nonatomic) void (^LATSpreadTableViewCellView)(UITableViewCell *cell);
- (void)registerCellClass:(NSString *)cellClass forRowObjectClass:(NSString *)rowObjectClass;
- (void)registerHeaderFooterViewClass:(NSString *)headerFooterViewClass forSectionObjectClass:(NSString *)sectionObjectClass;
@end
