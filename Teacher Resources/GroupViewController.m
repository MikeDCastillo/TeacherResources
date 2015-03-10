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


@interface GroupViewController () <UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GroupViewControllerDataSource *datasource;

@property (strong, nonatomic) UIView *addStudentsCV;
@property (strong, nonatomic) UITextField *addTextField;

@end

@implementation GroupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    self.datasource = [GroupViewControllerDataSource new];
    
    //Add Class PLUS button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGroup:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    //Navigation Bar Title
    self.title = @"Teacher Resources";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor trBlueColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    //Background Color
    self.view.backgroundColor= [UIColor whiteColor];
    
    //TableView Config
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    //DataSource + Delegate
    self.tableView.delegate = self;
    self.tableView.dataSource = self.datasource;
    [self.datasource registerTableView:self.tableView];
    
    
    [self.view addSubview:self.tableView];
    
    
}

- (void)addGroup:(id)sender {
    
    //Create Custom Subview for adding groups
    self.addStudentsCV = [[UIView alloc] initWithFrame:CGRectMake(-250, 0, self.view.frame.size.width, 64)];
    self.addStudentsCV.backgroundColor = [UIColor trBlueColor];
    
    //Add Group TextField
    self.addTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 24, 250, 35)];
    self.addTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.addTextField.delegate = self;
    self.addTextField.placeholder = @"Enter Group Title";
    [self.addTextField setReturnKeyType:UIReturnKeyDone];
    [self.addTextField becomeFirstResponder];
    [self.addStudentsCV addSubview:self.addTextField];
    
    //Add addGroup Button
    UIButton *addGroupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addGroupButton addTarget:self
                     action:@selector(addGroupButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    
    [addGroupButton setTitle:@"Add Group" forState:UIControlStateNormal];
    addGroupButton.tintColor = [UIColor whiteColor];
    addGroupButton.frame = CGRectMake(self.view.frame.size.width - 85, 35.0, 80.0, 20.0);
    [self.addStudentsCV addSubview:addGroupButton];

    [self.navigationController.view addSubview:self.addStudentsCV];
    [self moveOver:self.addStudentsCV thisMuch:250 withDuration:.2];
    
}

-(void)addGroupButtonPressed {
    if ([self.addTextField.text isEqualToString:@""]) {
        return;
    }
    [[GroupController sharedInstance] addGroupWithGroupName:self.addTextField.text];
    [self.tableView reloadData];
    [self moveOver:self.addStudentsCV thisMuch:-(self.view.frame.size.width) withDuration:.25];
    [self.addTextField resignFirstResponder];
}

#pragma - mark TextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        [textField resignFirstResponder];
        [self moveOver:self.addStudentsCV thisMuch:-(self.view.frame.size.width) withDuration:.25];
        return YES;
    }
    [self addGroupButtonPressed];
    return YES;
}

#pragma - mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.addStudentsCV removeFromSuperview];
    FeaturesViewController *featuresViewController = [FeaturesViewController new];
    
    [self.navigationController pushViewController:featuresViewController animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma - mark Animations

-(void)moveOver:(UIView *)view thisMuch:(float)distance withDuration:(float)duration {

    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x + distance, view.center.y);
        
    }];
}

@end
