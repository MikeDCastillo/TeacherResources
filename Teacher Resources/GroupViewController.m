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
#import "GroupTableViewDataSource.h"

@interface GroupViewController () <UITableViewDelegate,UITextFieldDelegate>

//@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) UILabel *pressPlusButtonLabel;
@property (strong, nonatomic) UILabel *openingLabel;
@property (strong, nonatomic) GroupTableViewDataSource *dataSource;
@property (strong, nonatomic) UIView *addClassCustomView;
@property (strong, nonatomic) UITextField *addTextField;
@property (strong, nonatomic) UIButton *addClassButton;
@property (nonatomic, strong) GroupViewController *groupViewController;
@property (assign, nonatomic) BOOL hasLaunched;

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    [self setupViews];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //DataSource + Delegate
    self.tableView.delegate = self;
    self.dataSource = [GroupTableViewDataSource new];
    [self.dataSource registerTableView:self.tableView];
    self.tableView.dataSource = self.dataSource;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)setupViews {
    //Add Class PLUS button
    self.addClassButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addClassButton setTitle:@"+" forState:UIControlStateNormal];
    self.addClassButton.frame = CGRectMake(0, 15.0, 30.0, 20.0);
    self.addClassButton.titleLabel.tintColor = [UIColor whiteColor];
    self.addClassButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:50.0];
    [self.addClassButton addTarget:self action:@selector(animatePlusButton) forControlEvents:UIControlEventTouchDown];
    [self.addClassButton addTarget:self action:@selector(addClassButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithCustomView:self.addClassButton];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //Navigation Bar Title
    self.title = @"Classes";
    self.navigationController.navigationBar.barTintColor = [UIColor woodColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    //TableView Config
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor chalkboardGreen];
    [self.view addSubview:self.tableView];
    
    if ([GroupController sharedInstance].groups.count == 0) {
        self.pressPlusButtonLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, 10, self.view.frame.size.width, 60)];
        self.pressPlusButtonLabel.text = @"Press the + button to add your first class!";
        self.pressPlusButtonLabel.textColor = [UIColor whiteColor];
        self.pressPlusButtonLabel.textAlignment = NSTextAlignmentCenter;
        self.pressPlusButtonLabel.font = [UIFont fontWithName:@"Chalkduster" size:20];
        self.pressPlusButtonLabel.numberOfLines = 0;
        self.pressPlusButtonLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.tableView addSubview:self.pressPlusButtonLabel];
        
        self.openingLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height / 3, self.view.frame.size.width, 150)];
        self.openingLabel.text = @"Welcome to Teacher Tools!";
        self.openingLabel.textColor = [UIColor whiteColor];
        self.openingLabel.textAlignment = NSTextAlignmentCenter;
        self.openingLabel.font = [UIFont fontWithName:@"Chalkduster" size:34];
        self.openingLabel.numberOfLines = 0;
        self.openingLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.tableView addSubview:self.openingLabel];
        self.hasLaunched = YES;
        [[NSUserDefaults standardUserDefaults] setBool:self.hasLaunched forKey:@"hasLanched"];
    }

}

- (void)addClassButtonPressed:(id)sender {
    if (self.openingLabel) {
        [self.openingLabel removeFromSuperview];
    }
    if (self.pressPlusButtonLabel) {
        [self.pressPlusButtonLabel removeFromSuperview];
    }
    //Create Custom Subview for adding groups
    self.addClassCustomView = [[UIView alloc] initWithFrame:CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, 64)];
    self.addClassCustomView.backgroundColor = [UIColor woodColor];
    
    //Add Group TextField
    self.addTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 24, self.view.frame.size.width * 0.7, 35)];
    self.addTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.addTextField.delegate = self;
    self.addTextField.placeholder = @"Enter Class Name";
    self.addTextField.font = [UIFont fontWithName:@"Chalkduster" size:14];
    [self.addTextField setReturnKeyType:UIReturnKeyDone];
    [self.addTextField becomeFirstResponder];
    [self.addClassCustomView addSubview:self.addTextField];
    
    //Add addGroup Button Custom View
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cancelButton addTarget:self
                     action:@selector(cancelButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    
    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:20];

    cancelButton.tintColor = [UIColor whiteColor];
    cancelButton.frame = CGRectMake(self.view.frame.size.width * 0.75, 35.0, 80.0, 20.0);
    [self.addClassCustomView addSubview:cancelButton];

    [self.navigationController.view addSubview:self.addClassCustomView];
    [self moveOver:self.addClassCustomView thisMuch:self.view.frame.size.width withDuration:.2];
    
}

-(void)cancelButtonPressed {
    [self moveOver:self.addClassCustomView thisMuch:-(self.view.frame.size.width) withDuration:.25];
    [self.addTextField resignFirstResponder];
}

#pragma mark - TextField Delegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text isEqualToString:@""]) {
        return NO;
    }
    [[GroupController sharedInstance] addGroupWithGroupName:textField.text];
    [self moveOver:self.addClassCustomView thisMuch:(self.view.frame.size.width) withDuration:.25];
    textField.text = @"";
    [self.tableView reloadData];
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.addClassCustomView removeFromSuperview];
    
    Group *currentGroup = [GroupController sharedInstance].groups[indexPath.row];
    
    FeaturesViewController *featuresViewController = [FeaturesViewController new];
    [featuresViewController updateWithGroup:currentGroup];
    
    NSSet *set = [currentGroup.members set];
    [GroupController sharedInstance].temporaryStudentList = [NSArray arrayWithArray:[set allObjects]];
    
    [self.navigationController pushViewController:featuresViewController animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}



#pragma mark - Animations

-(void)moveOver:(UIView *)view thisMuch:(float)distance withDuration:(float)duration {
    [UIView animateWithDuration:duration animations:^{
        view.center = CGPointMake(view.center.x + distance, view.center.y);
    }];
}

- (void)animatePlusButton {
    [self growsOnTouch:self.addClassButton withDuration:.3];
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
