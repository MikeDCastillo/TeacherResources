//
//  StudentListShufflerViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/13/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "StudentListShufflerViewController.h"

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
    self.navigationController.navigationBar.barTintColor = [UIColor trBlueColor];
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
    self.segmentControl.backgroundColor = [UIColor whiteColor];
    
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
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSString *student in self.group.members) {
        [array addObject:student];
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *sortedArray;
    sortedArray = [array sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.datasource.members = sortedArray;
    [self.tableView reloadData];
    
}

- (void)arrangeZtoA {
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSString *student in self.group.members) {
        [array addObject:student];
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    NSArray *sortedArray;
    sortedArray = [array sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.datasource.members = sortedArray;
    [self.tableView reloadData];
    
}

- (void)shuffle {
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSString *student in self.group.members) {
        [array addObject:student];
    }
    
    [GroupController sharedInstance].group = [[GroupController sharedInstance]shuffle:array];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}


@end
