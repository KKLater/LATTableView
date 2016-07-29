
//
//  LATSpreadHeaderFooterView.m
//  Later
//
//  Created by Later on 16/7/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "LATTableViewHeaderFooterView.h"

@implementation LATTableViewHeaderFooterView
- (void)configSectionObject:(id)sectionObject {
    
}
+ (CGFloat)configTableView:(UITableView *)tableView headerViewHightForSectionObject:(id)sectionObject {
    return 0;
}
+ (CGFloat)configTableView:(UITableView *)tableView footerViewHightForSectionObject:(id)sectionObject {
    return 0;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
