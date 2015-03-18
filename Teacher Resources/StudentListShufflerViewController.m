//
//  StudentListShufflerViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/13/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentListShufflerViewController.h"
#import "SWTableViewCell.h"

@interface StudentListShufflerViewController () <UITableViewDelegate, UITextFieldDelegate>

@end

@implementation StudentListShufflerViewController

- (void)updateWithGroup:(Group *)group {
    
    self.group = group;
}

- (NSString *)groupTitle {
    
    return self.group.title;
    
}

- (void)viewDidLoad {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [super viewDidLoad];
    [self.tableView reloadData];
    
    [self setupViews]; 
    
    self.datasource = [StudentListShufflerDataSource new];
    
    self.view.backgroundColor = [UIColor redColor];
    
    //Navigation Bar Title
    self.title = [self groupTitle];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor chalkboardGreen];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    //Background Color
    self.view.backgroundColor= [UIColor whiteColor];
    
    //DataSource + Delegate
    self.tableView.delegate = self;
    self.tableView.dataSource = self.datasource;
    [self.datasource registerTableView:self.tableView withGroup:self.group];
    
    
    [self.view addSubview:self.tableView];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (void)refresh {
   
    [self.tableView reloadData];

}


- (void)setupViews
{
    
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Names A - Z", @"Names Z - A", @"Shuffle", nil]];
    self.segmentControl.frame = CGRectMake(10, 10, self.view.frame.size.width - 2*10, 35);
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentControl.tintColor = [UIColor blackColor];
    self.segmentControl.backgroundColor = [UIColor lightGrayColor];
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
    [UIFont fontWithName:@"Chalkduster" size:15], NSFontAttributeName,
    [UIColor trBlueColor], NSForegroundColorAttributeName, nil];
    [self.segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    

    [self.segmentControl addTarget:self action:@selector(valueChanged:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:self.segmentControl];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.segmentControl];

}

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
            
        default:
            break;
    }
    
}

- (void)arrangeAtoZ {
    
    NSArray *array = [NSArray arrayWithArray:[GroupController sharedInstance].temporaryStudentList];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *sortedArray;
    sortedArray = [array sortedArrayUsingDescriptors:@[sortDescriptor]];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:sortedArray];
    [GroupController sharedInstance].temporaryStudentList = mutableArray;

    [self.tableView reloadData];
    
}

- (void)arrangeZtoA {
    
    NSArray *array = [NSArray arrayWithArray:[GroupController sharedInstance].temporaryStudentList];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    NSArray *sortedArray;
    sortedArray = [array sortedArrayUsingDescriptors:@[sortDescriptor]];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:sortedArray];
    [GroupController sharedInstance].temporaryStudentList = mutableArray;

    [self.tableView reloadData];
    
}

- (void)shuffle {
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:[[GroupController sharedInstance] shuffle:[GroupController sharedInstance].temporaryStudentList]];
    
    [GroupController sharedInstance].temporaryStudentList = mutableArray;
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}


@end
