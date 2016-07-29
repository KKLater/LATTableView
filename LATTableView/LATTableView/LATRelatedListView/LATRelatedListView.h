//
//  LATRelatedListView.h
//  Later
//
//  Created by Later on 16/7/2.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LATTableView.h"

@interface LATRelatedListView : UIView
@property (strong, nonatomic) LATTableView *leftTabListView;
@property (strong, nonatomic) LATTableView *rightListTableView;
@property (assign, nonatomic) CGRect leftTabListFrame;
@property (strong, nonatomic) NSArray *leftTabListObject;
@property (strong, nonatomic) NSArray *rightTableViewSectionObjects;
@end
