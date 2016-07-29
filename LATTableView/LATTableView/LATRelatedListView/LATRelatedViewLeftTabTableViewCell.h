//
//  LATRelatedViewLeftTabTableViewCell.h
//  Later
//
//  Created by Later on 16/7/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LATRelatedViewLeftTabTableViewCell : UITableViewCell
- (void)configCellObject:(id)rowObject NS_REQUIRES_SUPER;
+ (CGFloat)configTableView:(UITableView *)tableView hightForRowObject:(id)rowObject NS_REQUIRES_SUPER;
@end
