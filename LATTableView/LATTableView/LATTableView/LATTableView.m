//
//  LATSpreadTableView.m
//  Later
//
//  Created by Later on 16/7/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "LATTableView.h"
#import "LATTableViewSectionObject.h"
#import "LATTableViewCell.h"
#import "LATTableViewHeaderFooterView.h"
#import "LATTableViewCellObject.h"

@interface LATTableView ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSString *> *rowObjectViewCache;
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSString *> *sectionObjectViewCache;

@property (strong, nonatomic) NSMutableDictionary<NSString *, NSNumber *> *cellHightCache;
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSNumber *> *headerViewHightCache;
@property (strong, nonatomic) NSMutableDictionary<NSString *, NSNumber *> *footerViewHightCache;


@end
@implementation LATTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
#pragma mark publicMethod
- (void)registerCellClass:(NSString *)cellClass forRowObjectClass:(NSString *)rowObjectClass {
    [self registerClass:NSClassFromString(cellClass) forCellReuseIdentifier:[self cellReuseIdentifierForCellClass:cellClass]];
    [self.rowObjectViewCache setObject:cellClass forKey:rowObjectClass];
}
- (void)registerHeaderFooterViewClass:(NSString *)headerFooterViewClass forSectionObjectClass:(NSString *)sectionObjectClass {
    [self registerClass:NSClassFromString(headerFooterViewClass) forHeaderFooterViewReuseIdentifier:[self headerFooterViewReuseIdentifierForViewClass:headerFooterViewClass]];
    [self.sectionObjectViewCache setObject:headerFooterViewClass forKey:sectionObjectClass];
}
#pragma mark privateMethod
- (NSString *)cellReuseIdentifierForCellClass:(NSString *)cellClass {
    return [NSString stringWithFormat:@"com.later.CellReuseIdentifier.%@",cellClass];
}
- (NSString *)headerFooterViewReuseIdentifierForViewClass:(NSString *)headerFooterViewClass {
    return [NSString stringWithFormat:@"com.later.CellReuseIdentifier.%@",headerFooterViewClass];
    
}
#pragma mark delegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionObjects.count > 0 ? self.sectionObjects.count : 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.sectionObjects.count > section) {
        LATTableViewSectionObject *sectionObject = self.sectionObjects[section];
        return sectionObject.rowCount;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (self.sectionObjects.count > indexPath.section) {
        NSArray *rowObjects = self.sectionObjects[indexPath.section].rowObjects;
        if (rowObjects.count > indexPath.row) {
            id rowObject = rowObjects[indexPath.row];
            if ([rowObject isKindOfClass:[LATTableViewCellObject class]]) {
                ((LATTableViewCellObject *)rowObject).indexPath = indexPath;
            }
            NSString *cellClass = [self.rowObjectViewCache objectForKey:NSStringFromClass([rowObject class])];
            cell = [tableView dequeueReusableCellWithIdentifier:[self cellReuseIdentifierForCellClass:cellClass] forIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellReuseIdentifierForCellClass:cellClass]];
            }
            if ([cell isKindOfClass:[LATTableViewCell class]]) {
                [(LATTableViewCell *)cell configCellObject:rowObject];
                !self.LATSpreadTableViewCellView ?: self.LATSpreadTableViewCellView(cell);
            } else {
                NSLog(@"%@不是继承LATSpereadTableViewCell的子类cell，无法初始化数据",NSStringFromClass([cell class]));
            }
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.sectionObjects.count > indexPath.section) {
        NSArray *rowObjects = self.sectionObjects[indexPath.section].rowObjects;
        if (rowObjects.count > indexPath.row) {
            id rowObject = rowObjects[indexPath.row];
            if ([rowObject isKindOfClass:[LATTableViewCellObject class]]) {
                NSString *cellClass = [self.rowObjectViewCache objectForKey:NSStringFromClass([rowObject class])];
                if (cellClass.length > 0) {
                    if ([NSClassFromString(cellClass) isSubclassOfClass:[LATTableViewCell class]]) {
                        return [self cellHightWithCellClass:cellClass rowObject:(NSObject *)rowObject];
                    }else {
#if debug
                        NSLog(@"%@没有继承于LATSpereadTableViewCell", cellClass);
#endif
                    }
                } else {
#if debug
                    NSLog(@"没有和%@绑定的cellClass，请绑定%@的cellClass",NSStringFromClass([rowObject class]),NSStringFromClass([rowObject class]));
#endif
                }
            } else {
#if debug
                NSLog(@"%@没有继承于LATSpreadRowObject", NSStringFromClass([rowObject class]));
#endif
            }
        }
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *headerFooterView;
    if (self.sectionObjects.count > section) {
        id sectionObject = self.sectionObjects[section];
        if ([sectionObject isKindOfClass:[LATTableViewSectionObject class]]) {
            ((LATTableViewSectionObject *)sectionObject).section = section;
            NSString *headerFooterViewClass = [self.sectionObjectViewCache objectForKey:NSStringFromClass([sectionObject class])];
            if (headerFooterViewClass.length > 0) {
                headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[self headerFooterViewReuseIdentifierForViewClass:headerFooterViewClass]];
                if (!headerFooterView) {
                    headerFooterView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:[self headerFooterViewReuseIdentifierForViewClass:headerFooterViewClass]];
                }
                if ([headerFooterView isKindOfClass:[LATTableViewHeaderFooterView class]]) {
                    [(LATTableViewHeaderFooterView *)headerFooterView configSectionObject:sectionObject];
                    !self.LATSpreadTableViewHeaderView ?: self.LATSpreadTableViewHeaderView(headerFooterView);
                } else {
#if debug
                NSLog(@"%@没有继承于headerFooterViewClass", NSStringFromClass([headerFooterView class]));
#endif
                }
                return headerFooterView;
            } else {
#if debug
                NSLog(@"%@没有注册headerFooterViewClass",NSStringFromClass([sectionObject class]));
#endif
            }
        } else {
#if debug
            NSLog(@"%@没有继承于LATTableViewSectionObject", NSStringFromClass([sectionObject class]));
#endif
        }
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.sectionHeaderHeight > 0) {
        return self.sectionHeaderHeight;
    }
    if (self.sectionObjects.count > section) {
        id sectionObject = self.sectionObjects[section];
        if ([sectionObject isKindOfClass:[LATTableViewSectionObject class]]) {
            NSString *headerFooterViewClass = [self.sectionObjectViewCache objectForKey:NSStringFromClass([sectionObject class])];
            if (headerFooterViewClass.length > 0) {
                if ([NSClassFromString(headerFooterViewClass) isSubclassOfClass:[LATTableViewHeaderFooterView class]]) {
                    return [self headerViewHightWithHeaderFooterViewClass:headerFooterViewClass sectionObject:sectionObject];
                }else {
#if debug
                    NSLog(@"%@没有继承于LATSpreadHeaderFooterView", headerFooterViewClass);
#endif
                }
            } else {
#if debug
                NSLog(@"%@没有注册headerFooterViewClass",headerFooterViewClass);
#endif
            }
        } else {
#if debug
            NSLog(@"%@没有继承于LATTableViewSectionObject", NSStringFromClass([sectionObject class]));
#endif
        }
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerFooterView;
    if (self.sectionObjects.count > section) {
        id sectionObject = self.sectionObjects[section];
        if ([sectionObject isKindOfClass:[LATTableViewSectionObject class]]) {
            ((LATTableViewSectionObject *)sectionObject).section = section;
            NSString *headerFooterViewClass = [self.sectionObjectViewCache objectForKey:NSStringFromClass([sectionObject class])];
            if (headerFooterViewClass.length > 0) {
                headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:[self headerFooterViewReuseIdentifierForViewClass:headerFooterViewClass]];
                if (!headerFooterView) {
                    headerFooterView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:[self headerFooterViewReuseIdentifierForViewClass:headerFooterViewClass]];
                }
                if ([headerFooterView isKindOfClass:[LATTableViewHeaderFooterView class]]) {
                    [(LATTableViewHeaderFooterView *)headerFooterView configSectionObject:sectionObject];
                    !self.LATSpreadTableViewHeaderView ?: self.LATSpreadTableViewHeaderView(headerFooterView);
                } else {
#if debug
                    NSLog(@"%@没有继承于headerFooterViewClass", NSStringFromClass([headerFooterView class]));
#endif
                }
                return headerFooterView;
            } else {
#if debug
                NSLog(@"%@没有注册headerFooterViewClass",NSStringFromClass([sectionObject class]));
#endif
            }
        } else {
#if debug
            NSLog(@"%@没有继承于LATTableViewSectionObject", NSStringFromClass([sectionObject class]));
#endif
        }
    }
    return nil;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.sectionHeaderHeight > 0) {
        return self.sectionHeaderHeight;
    }
    if (self.sectionObjects.count > section) {
        id sectionObject = self.sectionObjects[section];
        if ([sectionObject isKindOfClass:[LATTableViewSectionObject class]]) {
            NSString *headerFooterViewClass = [self.sectionObjectViewCache objectForKey:NSStringFromClass([sectionObject class])];
            if (headerFooterViewClass.length > 0) {
                if ([NSClassFromString(headerFooterViewClass) isSubclassOfClass:[LATTableViewHeaderFooterView class]]) {
                    return [self footerViewHightWithHeaderFooterViewClass:headerFooterViewClass sectionObject:sectionObject];
                }else {
#if debug
                    NSLog(@"%@没有继承于LATSpreadHeaderFooterView", headerFooterViewClass);
#endif
                }
            } else {
#if debug
                NSLog(@"%@没有注册headerFooterViewClass",headerFooterViewClass);
#endif
            }
        } else {
#if debug
            NSLog(@"%@没有继承于LATTableViewSectionObject", NSStringFromClass([sectionObject class]));
#endif
        }
    }
    return 0;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id rowObject = nil;
    if (self.sectionObjects.count >= indexPath.section) {
        NSArray *rowObjects = self.sectionObjects[indexPath.section].rowObjects;
        if (rowObjects.count > indexPath.row) {
            rowObject = rowObjects[indexPath.row];
        }
    }
    BOOL needDeselect =  !self.LATSpreadTableViewCellDidSelectedBlock ?: self.LATSpreadTableViewCellDidSelectedBlock((LATTableView *)tableView, indexPath, rowObject);
    if (needDeselect) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
#pragma mark privateMethod
- (CGFloat)cellHightWithCellClass:(NSString *)cellClass rowObject:(NSObject *)rowObject {
    NSNumber *cellHight = [self.cellHightCache objectForKey:[self cacheHightKeyForViewClass:cellClass object:rowObject]];
    if (cellHight && [cellHight isKindOfClass:[NSNumber class]]) {
        if (cellHight.floatValue < 0) {
#if debug
            NSLog(@"%@没有实现cell高度的计算方法，请实现。",cellClass);
#endif
        } else {
            return cellHight.floatValue;
        }
    } else {
        NSString *cellClass = [self.rowObjectViewCache objectForKey:NSStringFromClass([rowObject class])];
        if (cellClass.length > 0) {
            if ([NSClassFromString(cellClass) isSubclassOfClass:[LATTableViewCell class]]) {
                CGFloat cellHightFloat = [NSClassFromString(cellClass) configTableView:self hightForRowObject:rowObject];
                if (cellHightFloat < 0) {
#if debug
                    
                    NSLog(@"%@没有实现cell高度的计算方法，请实现。",cellClass);
#endif
                } else {
                    [self cacheCellHight:cellHightFloat forCellClass:cellClass rowObject:rowObject];
                    return cellHightFloat;
                }
            }
        } else {
#if debug
            
            NSLog(@"没有和%@绑定的cellClass，请绑定%@的cellClass",NSStringFromClass([rowObject class]),NSStringFromClass([rowObject class]));
#endif
        }
    }
    return 0;
}
- (void)cacheCellHight:(CGFloat)cellHight forCellClass:(NSString *)cellClass rowObject:(NSObject *)rowObject {
    [self.cellHightCache setObject:@(cellHight) forKey:[self cacheHightKeyForViewClass:cellClass object:rowObject]];
}

- (CGFloat)headerViewHightWithHeaderFooterViewClass:(NSString *)viewClass sectionObject:(NSObject *)sectionObject {
    NSNumber *headerFooterHight = [self.headerViewHightCache objectForKey:[self cacheHightKeyForViewClass:viewClass object:sectionObject]];
    if (headerFooterHight && [headerFooterHight isKindOfClass:[NSNumber class]]) {
        if (headerFooterHight.floatValue < 0) {
#if debug
            NSLog(@"%@类没有实现headerFooterView高度的计算方法，请实现。",viewClass);
#endif
        } else {
            return headerFooterHight.floatValue;
        }
    } else {
        if (viewClass.length > 0) {
            if ([NSClassFromString(viewClass) isSubclassOfClass:[LATTableViewHeaderFooterView class]]) {
                CGFloat headerFooterViewHightFloat = [NSClassFromString(viewClass) configTableView:self headerViewHightForSectionObject:sectionObject];
                if (headerFooterViewHightFloat < 0) {
#if debug
                    NSLog(@"%@类没有实现headerFooterView高度的计算方法，请实现。",viewClass);
#endif
                } else {
                    [self cacheHeaderViewHight:headerFooterViewHightFloat forViewClass:viewClass sectionObject:sectionObject];
                    return headerFooterViewHightFloat;
                }
            }
        } else {
#if debug
            
            NSLog(@"没有和%@绑定的cellClass，请绑定%@的cellClass",NSStringFromClass([sectionObject class]),NSStringFromClass([sectionObject class]));
#endif
        }
    }
    return 0;
    
}
- (CGFloat)footerViewHightWithHeaderFooterViewClass:(NSString *)viewClass sectionObject:(NSObject *)sectionObject {
    NSNumber *headerFooterHight = [self.footerViewHightCache objectForKey:[self cacheHightKeyForViewClass:viewClass object:sectionObject]];
    if (headerFooterHight && [headerFooterHight isKindOfClass:[NSNumber class]]) {
        if (headerFooterHight.floatValue < 0) {
#if debug
            NSLog(@"%@类没有实现headerFooterView高度的计算方法，请实现。",viewClass);
#endif
        } else {
            return headerFooterHight.floatValue;
        }
    } else {
        if (viewClass.length > 0) {
            if ([NSClassFromString(viewClass) isSubclassOfClass:[LATTableViewHeaderFooterView class]]) {
                CGFloat headerFooterViewHightFloat = [NSClassFromString(viewClass) configTableView:self footerViewHightForSectionObject:sectionObject];
                if (headerFooterViewHightFloat < 0) {
#if debug
                    NSLog(@"%@类没有实现headerFooterView高度的计算方法，请实现。",viewClass);
#endif
                } else {
                    [self cacheFooterViewHight:headerFooterViewHightFloat forViewClass:viewClass sectionObject:sectionObject];
                    return headerFooterViewHightFloat;
                }
            }
        } else {
#if debug
            
            NSLog(@"没有和%@绑定的cellClass，请绑定%@的cellClass",NSStringFromClass([sectionObject class]),NSStringFromClass([sectionObject class]));
#endif
        }
    }
    return 0;
    
}
- (void)cacheHeaderViewHight:(CGFloat)viewHight forViewClass:(NSString *)ViewClass sectionObject:(NSObject *)sectionObject {
    [self.headerViewHightCache setObject:@(viewHight) forKey:[self cacheHightKeyForViewClass:ViewClass object:sectionObject]];
    
}
- (void)cacheFooterViewHight:(CGFloat)viewHight forViewClass:(NSString *)ViewClass sectionObject:(NSObject *)sectionObject {
    [self.footerViewHightCache setObject:@(viewHight) forKey:[self cacheHightKeyForViewClass:ViewClass object:sectionObject]];
    
}
- (NSString *)cacheHightKeyForViewClass:(NSString *)ViewClass object:(NSObject *)object {
    return [NSString stringWithFormat:@"%@%@",ViewClass,object];
}
#pragma setter/getter
- (NSMutableDictionary<NSString *,NSString *> *)rowObjectViewCache {
    if (!_rowObjectViewCache) {
        _rowObjectViewCache = [NSMutableDictionary new];
    }
    return _rowObjectViewCache;
}
- (NSMutableDictionary<NSString *,NSString *> *)sectionObjectViewCache {
    if (!_sectionObjectViewCache) {
        _sectionObjectViewCache = [NSMutableDictionary new];
    }
    return _sectionObjectViewCache;
}
- (NSMutableDictionary<NSString *,NSNumber *> *)cellHightCache {
    if (!_cellHightCache) {
        _cellHightCache = [NSMutableDictionary new];
    }
    return _cellHightCache;
}
- (NSMutableDictionary<NSString *, NSNumber *> *)headerViewHightCache {
    if (!_headerViewHightCache) {
        _headerViewHightCache = [NSMutableDictionary new];
    }
    return _headerViewHightCache;
}
- (NSMutableDictionary<NSString *, NSNumber *> *)footerViewHightCache {
    if (!_footerViewHightCache) {
        _footerViewHightCache = [NSMutableDictionary new];
    }
    return _footerViewHightCache;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
