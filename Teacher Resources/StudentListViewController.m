//
//  GroupDetailViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentListViewController.h"

@interface StudentListViewController () <UITableViewDelegate, UITextFieldDelegate>

@end

@implementation StudentListViewController

- (void)updateWithGroup:(Group *)group {
    
    self.group = group;
}

- (NSString *)groupTitle {
    
    return self.group.title;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    self.datasource = [StudentListDataSource new];
    
    //Add Class PLUS button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    //Navigation Bar Title
    self.title = [self groupTitle];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor trBlueColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    //Background Color
    self.view.backgroundColor= [UIColor whiteColor];
    
    //TableView Config
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    //DataSource + Delegate
    self.tableView.delegate = self;
    self.tableView.dataSource = self.datasource;
    [self.datasource registerTableView:self.tableView withGroup:self.group];
    
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)addGroup:(id)sender {
    
    //Create Custom Subview for adding groups
    self.studentNameView = [[UIView alloc] initWithFrame:CGRectMake(-250, 0, self.view.frame.size.width, 64)];
    self.studentNameView.backgroundColor = [UIColor trBlueColor];
    
    self.addTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 24, 250, 35)];
    self.addTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.addTextField.delegate = self;
    self.addTextField.placeholder = @"Enter Student Name";
    [self.addTextField setReturnKeyType:UIReturnKeyDone];
    [self.addTextField becomeFirstResponder];
    [self.studentNameView addSubview:self.addTextField];
    
    //Add addGroup Button
    UIButton *addGroupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addGroupButton addTarget:self
                       action:@selector(addGroupButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    
    [addGroupButton setTitle:@"Add" forState:UIControlStateNormal];
    addGroupButton.tintColor = [UIColor whiteColor];
    addGroupButton.frame = CGRectMake(self.view.frame.size.width - 85, 35.0, 80.0, 20.0);
    [self.studentNameView addSubview:addGroupButton];
    
    [self.navigationController.view addSubview:self.studentNameView];
    [self moveOver:self.studentNameView thisMuch:250 withDuration:.2];
    
}

-(void)addGroupButtonPressed {
    if ([self.addTextField.text isEqualToString:@""]) {
        return;
    }
    [[GroupController sharedInstance] addMemberWithMemberName:self.addTextField.text toGroup:self.group];
    [self.tableView reloadData];
    [self moveOver:self.studentNameView thisMuch:-(self.view.frame.size.width) withDuration:.25];
    [self.addTextField resignFirstResponder];
}

#pragma - mark TextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        [textField resignFirstResponder];
        [self moveOver:self.addTextField thisMuch:-(self.view.frame.size.width) withDuration:.25];
        return YES;
    }
    [self addGroupButtonPressed];
    return YES;
}

#pragma - mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

#pragma - mark Animations

-(void)moveOver:(UIView *)view thisMuch:(float)distance withDuration:(float)duration {
    
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x + distance, view.center.y);
        
    }];
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
