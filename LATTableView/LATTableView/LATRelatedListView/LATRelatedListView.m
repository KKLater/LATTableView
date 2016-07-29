//
//  LATRelatedListView.m
//  Later
//
//  Created by Later on 16/7/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "LATRelatedListView.h"
#import "LATSpreadSectionObject.h"
@interface LATRelatedListView ()
@end
@implementation LATRelatedListView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftTabListView];
        [self addSubview:self.rightListTableView];
    }
    return self;
}
#pragma mark getter/setter
- (LATTableView *)leftTabListView {
    if (!_leftTabListView) {
        _leftTabListView = [[LATTableView alloc] initWithFrame:CGRectMake(0, 0, 100, CGRectGetHeight(self.bounds)) style:UITableViewStylePlain];
        _leftTabListView.scrollsToTop = NO;
    }
    return _leftTabListView;
}
- (LATTableView *)rightListTableView {
    if (!_rightListTableView) {
        _rightListTableView = [[LATTableView alloc] initWithFrame:CGRectMake(100, 0, CGRectGetWidth(self.bounds) - 100, CGRectGetHeight(self.bounds)) style:UITableViewStylePlain];
        _rightListTableView.scrollsToTop = YES;
    }
    return _rightListTableView;
}
- (void)setLeftTabListObject:(NSArray *)leftTabListObject {
    _leftTabListObject = leftTabListObject;
    LATSpreadSectionObject *leftSectionObject = [[LATSpreadSectionObject alloc] init];
    leftSectionObject.isSpread = YES;
    leftSectionObject.rowObjects = [leftTabListObject mutableCopy];
    NSArray *leftSections = [NSArray arrayWithObject:leftSectionObject];
    self.leftTabListView.sectionObjects = [leftSections copy];
    [self.leftTabListView reloadData];
}
- (void)setRightTableViewSectionObjects:(NSArray *)rightTableViewSectionObjects {
    _rightTableViewSectionObjects = rightTableViewSectionObjects;
    self.rightListTableView.sectionObjects = [rightTableViewSectionObjects copy];
    [self.rightListTableView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
