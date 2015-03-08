//
//  GroupDetailViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "GroupDetailViewController.h"

@interface GroupDetailViewController () <UITableViewDelegate>

@end

@implementation GroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(45, 75, 150, 45)];
    self.groupNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.groupNameTextField.placeholder = @" Enter subject ";
    [self.view addSubview:self.groupNameTextField];
    
    self.studentNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(45, 150, 150, 45)];
    self.studentNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.studentNameTextField.placeholder = @" Enter student ";
    [self.view addSubview:self.studentNameTextField];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height - 100)];
    
    
    self.dataSource = [GroupDetailViewControllerDataSource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    [self.dataSource registerTableView:self.tableView];
    [self.view addSubview:self.tableView];
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Edit Student" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Edit name" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
        
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
