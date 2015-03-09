//
//  ViewController.m
//  Teacher Resources
//
//  Created by Parker Rushton on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "GroupViewController.h"
#import "UIColor+Category.h"
#import "FeaturesViewController.h"


@interface GroupViewController () <UITableViewDelegate>

@property (strong, nonatomic) UIView *addStudentsCV;

@end

@implementation GroupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    //DataSource + Delegate
    self.dataSource = [GroupViewControllerDataSource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    //Add Class PLUS button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    //Navigation Bar Title
    self.title = @"Teacher Resources";
    
    //Background Color
    self.view.backgroundColor= [UIColor slateColor];
    
    //TableView Config
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 44, self.view.frame.size.width - 40, self.view.frame.size.height)];
    
    [self.dataSource registerTableView:self.tableView];
    [self.view addSubview:self.tableView];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FeaturesViewController *featuresViewController = [FeaturesViewController new];
    
    [self.navigationController pushViewController:featuresViewController animated:YES];
    
}

- (void)addGroup:(id)sender {
    
    //Create Custome Subview for adding students
    self.addStudentsCV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 64)];
    self.addStudentsCV.backgroundColor = [UIColor redColor];
    
    //Add TextField
    UITextField *addTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 100, 25)];
    [self.addStudentsCV addSubview:addTextField];
    
    //Add Cancel Button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton addTarget:self
                     action:@selector(cancel)
           forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.frame = CGRectMake(self.view.frame.size.width - 80, 30.0, 30.0, 30.0);
    [self.addStudentsCV addSubview:cancelButton];

    [self.navigationController.view addSubview:self.addStudentsCV];

    
}

-(void)cancel {
    [self.addStudentsCV removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
