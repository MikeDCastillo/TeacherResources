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
#import "SWTableViewCell.h"


@interface GroupViewController () <UITableViewDelegate, UITableViewDataSource, SWTableViewCellDelegate,UITextFieldDelegate>

//@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UIView *addStudentsCV;
@property (strong, nonatomic) UITextField *addTextField;

@end

@implementation GroupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
        
    //Add Class PLUS button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(addGroup:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    //Navigation Bar Title
    self.title = @"Teacher Resources";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor chalkboardGreen];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    //Background Color
    self.view.backgroundColor= [UIColor whiteColor];
    
    //TableView Config
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    //DataSource + Delegate
    [self registerTableView:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
    self.addTextField.font = [UIFont fontWithName:@"Chalkduster" size:14];
    [self.addTextField setReturnKeyType:UIReturnKeyDone];
    [self.addTextField becomeFirstResponder];
    [self.addStudentsCV addSubview:self.addTextField];
    
    //Add addGroup Button Custom View
    UIButton *addGroupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addGroupButton addTarget:self
                     action:@selector(addGroupButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    
    [addGroupButton setTitle:@"+" forState:UIControlStateNormal];
    addGroupButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:50];

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

#pragma mark - TextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        [textField resignFirstResponder];
        [self moveOver:self.addStudentsCV thisMuch:-(self.view.frame.size.width) withDuration:.25];
        return YES;
    }
    [self addGroupButtonPressed];
    return YES;
}

#pragma mark - TableView DataSource Methods

- (void)registerTableView:(UITableView *)tableView {
    [tableView registerClass:[SWTableViewCell class] forCellReuseIdentifier:@"cellID"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [GroupController sharedInstance].groups.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    
    SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.delegate = self;
    
    if (cell == nil) {
        cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.leftUtilityButtons = [self leftButton];
        cell.rightUtilityButtons = [self rightButton];
        
    }
    cell.leftUtilityButtons = [self leftButton];
    cell.rightUtilityButtons = [self rightButton];
    
    Group *group = [GroupController sharedInstance].groups[indexPath.row];
    cell.textLabel.text = group.title;
    cell.textLabel.font = [UIFont fontWithName:@"Chalkduster" size:20];

    
    //Cell Subtitle
    NSString *numberOfStudents = [NSString stringWithFormat:@"%lu Members", (unsigned long)[GroupController sharedInstance].group.members.count];
    if ([GroupController sharedInstance].group.members.count == 0) {
        
    }
    else {
        cell.detailTextLabel.text = numberOfStudents;
    }
    
    return cell;
}

#pragma mark - TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.addStudentsCV removeFromSuperview];
    
    FeaturesViewController *featuresViewController = [FeaturesViewController new];
    [featuresViewController updateWithGroup:[GroupController sharedInstance].groups[indexPath.row]];
    
    [self.navigationController pushViewController:featuresViewController animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma mark - SWTableViewCell Methods

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];

    StudentListViewController *studentListViewController = [StudentListViewController new];
    [studentListViewController updateWithGroup:[[GroupController sharedInstance].groups objectAtIndex:cellIndexPath.row]];
        [self.navigationController presentViewController:studentListViewController animated:YES completion:nil];

}

-(void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    // Delete button was pressed
    NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
    
    [[GroupController sharedInstance] removeGroup:[[GroupController sharedInstance].groups objectAtIndex:cellIndexPath.row]];
    [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
}

- (NSArray *)leftButton {
    NSMutableArray *leftUtilityButton = [NSMutableArray new];
    
    [leftUtilityButton sw_addUtilityButtonWithColor:[UIColor chalkboardGreen] icon:[UIImage imageNamed:@"list"]];
    
    return leftUtilityButton;
}

- (NSArray *)rightButton {
    NSMutableArray *rightUtilityButton = [NSMutableArray new];
    
    [rightUtilityButton sw_addUtilityButtonWithColor:[UIColor redColor] icon:[UIImage imageNamed:@"cross"]];
    
    return rightUtilityButton;
}

-(BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell {
    return YES;
}

#pragma mark - Animations

-(void)moveOver:(UIView *)view thisMuch:(float)distance withDuration:(float)duration {

    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x + distance, view.center.y);
        
    }];
}




@end
