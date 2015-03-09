//
//  ViewController.m
//  Teacher Resources
//
//  Created by Parker Rushton on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "GroupViewController.h"


@interface GroupViewController () <UITableViewDelegate>

@end

@implementation GroupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    self.navBar = [[UINavigationBar alloc]init];
    [self.view addSubview:self.navBar];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup:)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.title = @"Teacher's Pet";
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height - 100)];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(95, 90, 180, 45)];
    self.label.text = @" Click + to add class! ";
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:18];
    self.label.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.label];
    
    self.dataSource = [GroupViewControllerDataSource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    [self.dataSource registerTableView:self.tableView];
    [self.view addSubview:self.tableView];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    GroupDetailViewController *groupDetailViewController = [GroupDetailViewController new];
    
    [groupDetailViewController updateWithGroup:[GroupController sharedInstance].groupNamesArray[indexPath.row]];
    
    [self.navigationController pushViewController:groupDetailViewController animated:YES];
    
}

- (void)addGroup:(id)sender {
    
    GroupDetailViewController *groupDetailViewController = [GroupDetailViewController new];
    
    [self.navigationController pushViewController:groupDetailViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
