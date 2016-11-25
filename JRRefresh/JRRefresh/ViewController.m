//
//  ViewController.m
//  JRRefresh
//
//  Created by AlanWang on 16/11/17.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import "ViewController.h"
#import "JRRefresh.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor grayColor];
    
    
    __weak typeof(self) weakSelf = self;
    [self.tableView jr_addHeaderWithRefreshBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView jr_stopLoading];
            [_datas removeAllObjects];
            for (int i = 0; i < 20; i++) {
                [_datas addObject:@"cell data"];
            }
            [weakSelf.tableView reloadData];
        });
    }];
    
    [self.tableView jr_addFooterWithRefreshBlock:^{
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i = 0; i < 20; i++) {
                [_datas addObject:@"cell data"];
            }
            [weakSelf.tableView reloadData];
            [weakSelf.tableView jr_stopLoading];
        });
        
    }];
    
    
   
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor grayColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cee %ld",(long)indexPath.row];
    return cell;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor grayColor];
        
    }
    return _tableView;
}
- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [[NSMutableArray alloc] init];
    }
    return _datas;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
