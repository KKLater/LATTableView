//
//  LATSpreadHeaderFooterView.h
//  Later
//
//  Created by Later on 16/7/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LATTableViewHeaderFooterView : UITableViewHeaderFooterView
- (void)configSectionObject:(id)sectionObject NS_REQUIRES_SUPER;
+ (CGFloat)configTableView:(UITableView *)tableView headerViewHightForSectionObject:(id)sectionObject NS_REQUIRES_SUPER;
+ (CGFloat)configTableView:(UITableView *)tableView footerViewHightForSectionObject:(id)sectionObject NS_REQUIRES_SUPER;

@end
