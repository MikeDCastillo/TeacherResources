//
//  GroupDetailViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentListViewController.h"

@interface StudentListViewController () <UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIView *studentNameView;
@property (nonatomic, strong) UITextField *addTextField;

@end

@implementation StudentListViewController

- (void)updateWithGroup:(Group *)group {
    
    self.group = group;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    self.view.backgroundColor= [UIColor whiteColor];
    self.datasource = [StudentListDataSource new];
    
    //Toolbar
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 74)];
//    toolbar.backgroundColor = [UIColor trBlueColor];
    toolbar.barStyle = UIBarStyleBlack;
    toolbar.barTintColor = [UIColor trBlueColor];
    [toolbar setTranslucent:NO];
    
    //Toolbar Items
    UIBarButtonItem *addStudentButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addStudent)];
    addStudentButton.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem	*flexy = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[flexy,addStudentButton];
    [self.view addSubview:toolbar];
    
    //TableView Config
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 74, self.view.frame.size.width, self.view.frame.size.height - 124) style:UITableViewStyleGrouped];
    
    //DataSource + Delegate
    self.tableView.delegate = self;
    self.tableView.dataSource = self.datasource;
    [self.datasource registerTableView:self.tableView withGroup:self.group];
    
    //Done Button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneButton.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton.titleLabel setFont:[UIFont fontWithName:@"" size:16]];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setBackgroundColor:[UIColor fern]];
    [doneButton addTarget:self action:@selector(removeAddStudentsView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:doneButton];
    
}

- (void)addStudent {
    
    //Create Custom Subview for adding students
    self.studentNameView = [[UIView alloc] initWithFrame:CGRectMake(-250, 0, self.view.frame.size.width, 74)];
    self.studentNameView.backgroundColor = [UIColor fern];
    
    //Text Field
    self.addTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 32, 250, 35)];
    self.addTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.addTextField.delegate = self;
    self.addTextField.placeholder = @"Enter Student Name";
    [self.addTextField setReturnKeyType:UIReturnKeyDefault];
    [self.addTextField becomeFirstResponder];
    
    [self.studentNameView addSubview:self.addTextField];
    
    //Add New Student Button
    UIButton *addStudentButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addStudentButton addTarget:self
                       action:@selector(addStudentButtonPressed)
             forControlEvents:UIControlEventTouchUpInside];
    
    [addStudentButton setTitle:@"Add" forState:UIControlStateNormal];
    addStudentButton.tintColor = [UIColor whiteColor];
    addStudentButton.frame = CGRectMake(self.view.frame.size.width - 85, 43.0, 80.0, 20.0);
    [self.studentNameView addSubview:addStudentButton];
    
    [self.view addSubview:self.studentNameView];
    [self moveOver:self.studentNameView thisMuch:250 withDuration:.2];
    
}

-(void)addStudentButtonPressed {
    if ([self.addTextField.text isEqualToString:@""]) {
        return;
    }
    [[GroupController sharedInstance] addMemberWithMemberName:self.addTextField.text toGroup:self.group];
    [self.tableView reloadData];
    [self moveOver:self.studentNameView thisMuch:-(self.view.frame.size.width) withDuration:.25];
    [self.addTextField resignFirstResponder];
}

- (void)removeAddStudentsView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma - mark TextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        [textField resignFirstResponder];
        [self moveOver:self.studentNameView thisMuch:-(self.view.frame.size.width) withDuration:.25];
        return YES;
    }
    [self addStudentButtonPressed];
    
    return YES;
}

#pragma - mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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


@end
