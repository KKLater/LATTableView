//
//  ArticleCell.m
//  LATTableView
//
//  Created by Later on 16/7/29.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "ArticleCell.h"
#import "ArticleObject.h"
@interface ArticleCell ()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@end
@implementation ArticleCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
    }
    return self;
}
- (void)layoutSubviews {
    self.titleLabel.frame = CGRectMake(20, 10, CGRectGetWidth(self.frame) - 40, 30);
    self.contentLabel.frame = CGRectMake(20, 50, CGRectGetWidth(self.frame) - 40, 95);
}
- (void)configCellObject:(ArticleObject *)rowObject {
    [super configCellObject:rowObject];
    self.titleLabel.text = rowObject.title;
    self.contentLabel.text = rowObject.brief;
}
+ (CGFloat)configTableView:(UITableView *)tableView hightForRowObject:(id)rowObject {
    [super configTableView:tableView hightForRowObject:rowObject];
    return 200;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}
- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.numberOfLines = 3;
    }
    return _contentLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
