//
//  LATRelatedViewLeftTabTableViewCell.m
//  Later
//
//  Created by Later on 16/7/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "LATRelatedViewLeftTabTableViewCell.h"

@implementation LATRelatedViewLeftTabTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configCellObject:(id)rowObject {
    
}
+ (CGFloat)configTableView:(UITableView *)tableView hightForRowObject:(id)rowObject {
    return 44;
}
@end
