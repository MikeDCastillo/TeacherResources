//
//  StudentListShufflerViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/13/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentListViewController.h"

@interface StudentListViewController () <UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) UIButton *addStudentButton;
@property (strong, nonatomic) UIView *addStudentsCustomView;
@property (strong, nonatomic) UITextField *addTextField;
@property (strong, nonatomic) UIButton *cancelButton;

@end

@implementation StudentListViewController

- (void)updateWithGroup:(Group *)group {
    
    self.group = group;
}

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    [self.tableView reloadData];
    [self setupViews];
    [self resetTemporaryList];
    
    //Navigation Bar Title
    self.title = self.group.title;
    
    //Background Color
    self.view.backgroundColor= [UIColor chalkboardGreen];
    
    //DataSource + Delegate
    self.datasource = [StudentListDataSource new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self.datasource;
    [self.datasource registerTableView:self.tableView withGroup:self.group];
}

-(void)resetTemporaryList {
    NSSet *set = [self.group.members set];
    [GroupController sharedInstance].temporaryStudentList = [NSArray arrayWithArray:[set allObjects]];
}

- (void)refresh {
    [self.tableView reloadData];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor redColor];
    //TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 94) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor chalkboardGreen];
    [self.view addSubview:self.tableView];
    
    //Add Students Plus Button
    self.addStudentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addStudentButton setTitle:@"+" forState:UIControlStateNormal];
    self.addStudentButton.frame = CGRectMake(0, 0, 40.0, 20.0);
    self.addStudentButton.titleLabel.tintColor = [UIColor whiteColor];
    self.addStudentButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:50.0];
    [self.addStudentButton addTarget:self action:@selector(animatePlusButton) forControlEvents:UIControlEventTouchDown];
    [self.addStudentButton addTarget:self action:@selector(addStudent) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addStudentButton];

    //Segmented Control
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"A - Z", @"Z - A", @"Shuffle", nil]];
    self.segmentControl.frame = CGRectMake(10, 10, self.view.frame.size.width - 2 * 10, 35);
    self.segmentControl.selectedSegmentIndex = 2;
    self.segmentControl.tintColor = [UIColor whiteColor];
    self.segmentControl.backgroundColor = [UIColor clearColor];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
    [UIFont fontWithName:@"Chalkduster" size:15], NSFontAttributeName,
    [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.segmentControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:self.segmentControl];
}

-(void)setupCustomView {
    //Create Custom Subview for adding students
    self.addStudentsCustomView = [[UIView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 0 , self.view.frame.size.width, 64)];
    self.addStudentsCustomView.backgroundColor = [UIColor woodColor];
    
    //Add Student TextField
    self.addTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 24, self.view.frame.size.width * 0.7, 35)];
    self.addTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.addTextField.delegate = self;
    self.addTextField.placeholder = @"Enter Student Name";
    self.addTextField.font = [UIFont fontWithName:@"Chalkduster" size:14];
    [self.addTextField setReturnKeyType:UIReturnKeyDone];
    [self.addTextField becomeFirstResponder];
    [self.addStudentsCustomView addSubview:self.addTextField];
    
    //Add Cancel Button
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:20];
    
    cancelButton.tintColor = [UIColor whiteColor];
    cancelButton.frame = CGRectMake(self.view.frame.size.width * 0.75, 35.0, 80.0, 20.0);
    [self.addStudentsCustomView addSubview:cancelButton];
    
    [self.navigationController.view addSubview:self.addStudentsCustomView];

}

- (void)cancelButtonPressed {
    [self moveOver:self.addStudentsCustomView thisMuch:-(self.view.frame.size.width) withDuration:.25];
    [self.addTextField resignFirstResponder];
}

- (void)addStudent {
    [self setupCustomView];
    [self moveOver:self.addStudentsCustomView thisMuch:self.view.frame.size.width withDuration:.2];
}


#pragma mark - TextField Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        [textField resignFirstResponder];
        [self moveOver:self.addStudentsCustomView thisMuch:-(self.view.frame.size.width) withDuration:.25];
        return YES;
    }
    else {
        
        [[GroupController sharedInstance] addMemberWithMemberName:textField.text toGroup:self.group];
        [self.tableView reloadData];
        textField.text = @"";
    }
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [self.tableView reloadData];
}

#pragma mark - Segmented Control

- (void)valueChanged:(UISegmentedControl *)segment {
    switch (segment.selectedSegmentIndex) {
        case 0: {
            [self arrangeAtoZ];
            break; }
        case 1: {
            [self arrangeZtoA];
            break; }
        case 2: {
            [self shuffle];
            break; }
    }
}

- (void)arrangeAtoZ {
    NSArray *array = [NSArray arrayWithArray:[self.group.members array]];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *sortedArray;
    sortedArray = [array sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.group.members = [NSOrderedSet orderedSetWithArray:sortedArray];

    [self.tableView reloadData];
}

- (void)arrangeZtoA {
    NSArray *array = [NSArray arrayWithArray:[self.group.members array]];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    self.group.members = [NSOrderedSet orderedSetWithArray:[array sortedArrayUsingDescriptors:@[sortDescriptor]]];
    [self.tableView reloadData];
}

- (void)shuffle {
    NSArray *array = [NSArray arrayWithArray:[self.group.members array]];
    array = [NSMutableArray arrayWithArray:[[GroupController sharedInstance] shuffle:array]];
    self.group.members = [NSOrderedSet orderedSetWithArray:array];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

#pragma mark - Animations

-(void)moveOver:(UIView *)view thisMuch:(float)distance withDuration:(float)duration {
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x + distance, view.center.y);
    }];
}

- (void)animatePlusButton {
    [self growsOnTouch:self.addStudentButton withDuration:.3];
}

- (void)growsOnTouch:(UIView *)view withDuration:(float)duration {
    CGAffineTransform bigger = CGAffineTransformMakeScale(5, 5);
    CGAffineTransform smaller = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:duration animations:^{
        view.transform = bigger;
        view.transform = smaller;
    }];
}

@end
