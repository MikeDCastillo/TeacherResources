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
    
    self.groupNameTextField.text = group.title;
}

- (NSString *)groupTitle {
    
    Group *group = [GroupController sharedInstance].groupNamesArray[[GroupController sharedInstance].groupSelected];
    
    NSString *titleOfGroup = group.title;
    
    return titleOfGroup;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [self groupTitle];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.studentNameTextField.delegate = self;
    
//    self.groupNameTextField.text = self.group.title;
    
    
    //Add Student Text Field
    self.studentNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(45, 100, 150, 45)];
    self.studentNameTextField.borderStyle = UITextBorderStyleRoundedRect;
//    [self.studentNameTextField setReturnKeyType:UIReturnKeyDefault];
    [self.studentNameTextField becomeFirstResponder];
    self.studentNameTextField.placeholder = @" Enter student ";
    [self.view addSubview:self.studentNameTextField];
    
    //Add Clear Button
    self.clearButton = [[UIButton alloc]initWithFrame:CGRectMake(45, 165, 80, 45)];
    [self.clearButton setTitle:@" Clear " forState:(UIControlStateNormal)];
    [self.clearButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.clearButton.backgroundColor = [UIColor slateColor];
    [self.clearButton addTarget:self action:@selector(clearField:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearButton];
    
    //Add Student Button
    self.addStudentButton = [[UIButton alloc]initWithFrame:CGRectMake(280, 100, 60, 45)];
    [self.addStudentButton setTitle:@" Add " forState:(UIControlStateNormal)];
    self.addStudentButton.backgroundColor = [UIColor slateColor];
    [self.addStudentButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.addStudentButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.addStudentButton addTarget:self action:@selector(saveStudents:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addStudentButton];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 250, self.view.frame.size.width, self.view.frame.size.height - 100)];
    
    
    self.dataSource = [StudentListDataSource new];
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self;
    
    [self updateWithGroup:self.group];
    [self.dataSource registerTableView:self.tableView];
    [self.view addSubview:self.tableView];
    
}

- (void)clearField:(id)sender {
    
    self.studentNameTextField.text = @"";
    
}

- (void)saveGroups:(id)sender {
    
    if (self.group) {
        self.group.title = self.groupNameTextField.text;
        
        [[GroupController sharedInstance]synchronize];
    }
    else {
        [[GroupController sharedInstance] addGroupWithGroupName:self.groupNameTextField.text];
    }
    
    
}

- (void)saveStudents:(id)sender {
    
    if ([self.studentNameTextField.text isEqualToString:@""]) {
        return;
    }
    [[GroupController sharedInstance] addMemberWithMemberName:self.studentNameTextField.text];
    [self.tableView reloadData];

    [self.studentNameTextField resignFirstResponder];
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self saveStudent];
    return YES;
}

- (void)saveStudent {
    if ([self.studentNameTextField.text isEqualToString:@""]) {
        return;
    }
    [[GroupController sharedInstance] addMemberWithMemberName:self.studentNameTextField.text];
    [self.tableView reloadData];
    
    [self.studentNameTextField resignFirstResponder];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Edit Student" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Edit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//
//        
//    }]];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//
//    }]];
//    
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//    }]];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
    
    
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
