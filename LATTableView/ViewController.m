//
//  ViewController.m
//  LATTableView
//
//  Created by Later on 16/7/29.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "ViewController.h"
#import "ArticleObject.h"
#import "ArticleCell.h"
#import "LATTableViewSectionObject.h"
@interface ViewController ()
@property (strong, nonatomic) LATTableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.frame = [UIScreen mainScreen].bounds;
    [self requestData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)requestData {
    __weak typeof(self)weakSelf = self;
    [[AFHTTPSessionManager manager] GET:@"http://app.idaxiang.org/api/v1_0/art/list?pageSize=20" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if (responseObject) {
            NSDictionary *body = responseObject[@"body"];
            if (body) {
                NSArray *articles = body[@"article"];
                NSMutableArray *articleObjects = [NSMutableArray new];
                [articles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    ArticleObject *object = [[ArticleObject alloc] initWithDictionary:obj];
                    [articleObjects addObject:object];
                }];
                LATTableViewSectionObject *section = [[LATTableViewSectionObject alloc] init];
                section.rowObjects = articleObjects;
                weakSelf.tableView.sectionObjects = [@[section] mutableCopy];
                [weakSelf.tableView reloadData];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark getter/setter
- (LATTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LATTableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerCellClass:NSStringFromClass([ArticleCell class]) forRowObjectClass:NSStringFromClass([ArticleObject class])];
    }
    return _tableView;
}
@end
