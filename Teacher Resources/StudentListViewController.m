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
    
    UIView *addStudentsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    addStudentsView.backgroundColor = [UIColor trBlueColor];
    
    //Plus Button
    UIButton *addStudentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addStudentButton setTitle:@"+" forState:UIControlStateNormal];
    addStudentButton.frame = CGRectMake(self.view.frame.size.width - 110, 35.0, 150.0, 20.0);
    addStudentButton.titleLabel.tintColor = [UIColor whiteColor];
    addStudentButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:50.0];
    [addStudentButton addTarget:self action:@selector(addStudent) forControlEvents:UIControlEventTouchUpInside];
    
    [addStudentsView addSubview:addStudentButton];
    
    //Class Title
    UILabel *groupNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, 250, 25)];
    groupNameLabel.text = self.group.title;
    groupNameLabel.textAlignment = NSTextAlignmentCenter;
    groupNameLabel.font = [UIFont fontWithName:@"Chalkduster" size:28];
    groupNameLabel.textColor = [UIColor whiteColor];
    [addStudentsView addSubview:groupNameLabel];
    
    [self.view addSubview:addStudentsView];
    
    //TableView Configuration
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 114) style:UITableViewStyleGrouped];
    
    //DataSource + Delegate
    self.tableView.delegate = self;
    self.tableView.dataSource = self.datasource;
    [self.datasource registerTableView:self.tableView withGroup:self.group];
    
    //Done Button
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    doneButton.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:18]];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setBackgroundColor:[UIColor fern]];
    [doneButton addTarget:self action:@selector(removeAddStudentsView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:doneButton];
    
}

- (void)addStudent {
    
//Create Custom Subview for adding students
    self.studentNameView = [[UIView alloc] initWithFrame:CGRectMake(-(self.view.frame.size.width), 0, self.view.frame.size.width, 64)];
    self.studentNameView.backgroundColor = [UIColor fern];
    
    //Text Field
    self.addTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 22, 250, 35)];
    self.addTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.addTextField.delegate = self;
    self.addTextField.placeholder = @"Enter Student Name";
    self.addTextField.returnKeyType = UIReturnKeyDefault;
    [self.addTextField becomeFirstResponder];
    
    [self.studentNameView addSubview:self.addTextField];
    
    //Add New Student Button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelButton setTintColor:[UIColor whiteColor]];
    [cancelButton.titleLabel setFont:[UIFont fontWithName:@"Chalkduster" size:20]];
    [cancelButton setFrame: CGRectMake(self.view.frame.size.width - 85, 31, 80, 20)];
    [self.studentNameView addSubview:cancelButton];
    
    [self.view addSubview:self.studentNameView];
    [self moveOver:self.studentNameView thisMuch:self.view.frame.size.width withDuration:.2];
    
}

- (void)cancelButtonPressed {

    [self moveOver:self.studentNameView thisMuch:-(self.view.frame.size.width) withDuration:.25];
    [self.addTextField resignFirstResponder];
}

- (void)removeAddStudentsView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        return NO;
    }
    else {
    
    [[GroupController sharedInstance] addMemberWithMemberName:textField.text toGroup:self.group];
        [self.tableView reloadData];
        textField.text = @"";
    }
    return NO;
}

#pragma mark - TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

#pragma mark -  Animations

- (void)moveOver:(UIView *)view thisMuch:(float)distance withDuration:(float)duration {
    
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x + distance, view.center.y);
        
    }];
}

@end
