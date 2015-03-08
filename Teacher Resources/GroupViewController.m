//
//  ViewController.m
//  Teacher Resources
//
//  Created by Parker Rushton on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "GroupViewController.h"


@interface GroupViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) GroupViewControllerDataSource *dataSource; 

@end

@implementation GroupViewController

- (UITableView *)makeTableView {
    
    CGFloat x = 0;
    CGFloat y = 75;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 75;
    CGRect tableFrame = CGRectMake(x,y,width,height);
    
    self.tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStyleGrouped];
    
    self.tableView.rowHeight = 60;
    self.tableView.scrollEnabled = YES;
    
    return self.tableView;
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBar = [[UINavigationBar alloc]init];
    [self.view addSubview:self.navBar];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    self.title = @"Teacher's Pet";
    
    
    self.tableView = [self makeTableView];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    
    self.dataSource = [GroupViewControllerDataSource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    [self.dataSource registerTableView:self.tableView];
    [self.view addSubview:self.tableView];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    GroupDetailViewController *groupDetailViewController = [GroupDetailViewController new];
    
    
    [self.navigationController pushViewController:groupDetailViewController animated:YES];
    
}

- (void)addGroup:(id)sender {
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
