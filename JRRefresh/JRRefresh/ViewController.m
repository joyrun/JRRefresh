//
//  ViewController.m
//  JRRefresh
//
//  Created by AlanWang on 16/11/17.
//  Copyright © 2016年 AlanWang. All rights reserved.
//

#import "ViewController.h"
#import "JRRefresh.h"
#import "UIScrollView+JRRefresh.h"
#import "JRRefreshHeader.h"
#import "JRRefreshCircleView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor grayColor];
    
    JRRefreshHeader *header = [[JRRefreshHeader alloc] initWithFrame:CGRectMake(0, -20, 200, 60)];
    JRRefreshCircleView *cir = [[JRRefreshCircleView alloc] initWithCenter:CGPointMake(self.tableView.jr_centerX, 20)];
    [self.tableView addSubview:cir];
    header.indicatorView = cir;
    [header setJRRefreshHeaderPullingBlock:^(CGFloat percent) {
        JR_DebugLog(@"%f",percent);
        [cir setProgress:percent scrollView:self.tableView];
    }];
    self.tableView.jr_header = header;
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor grayColor];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor grayColor];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
