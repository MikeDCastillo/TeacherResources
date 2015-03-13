//
//  RandomizedGroupsViewController.m
//  Teacher Resources
//
//  Created by Ethan Hess on 3/6/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "RandomizedGroupsViewController.h"
#import "MembersCollectionViewCell.h"
#import "NewStudentViewController.h"
#import "RandomizedViewControllerDataSource.h"
#import "StudentController.h"
#import "Member.h"
#import "UIColor+Category.h"

@interface RandomizedGroupsViewController ()


@property (nonatomic,strong) RandomizedViewControllerDataSource * dataSource;
@property (nonatomic,strong) StudentController *modelController;
@property (nonatomic,strong) MembersCollectionViewCell * customCell;


@end

@implementation RandomizedGroupsViewController

@synthesize screenHeight,screenWidth,customCell;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelController = [StudentController new];
        self.usableArray = [NSMutableArray arrayWithArray:[StudentController SharedInstance].students];
        self.dataSource = [RandomizedViewControllerDataSource new];
    }
    return self;
}

- (void)updateWithGroup:(Group *)group {
    
    self.group = group;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    screenHeight = self.view.frame.size.height;
    screenWidth = self.view.frame.size.width;
    
    [self registerNotifications];
    
    [self setupNavigationBar];
    
    [self setupCollectionView];
    
    [self setupToolBar];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshData];
    
}

#pragma mark - Setup CollectionView

- (void)setupCollectionView {
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0.0, 5.0, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    
    
    [self.collectionView setBackgroundColor:[UIColor trBlueColor]];
    [self.dataSource registerCollectionView:self.collectionView];
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CGSize itemSize = CGSizeMake((screenWidth /numberOfPeopleInGroup) - 6 , ((screenHeight - 64) / 5) / 2);
    return itemSize;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(MembersCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath; {
    
    [cell updateLabelFrame:CGRectMake(0, 0, (screenWidth /numberOfPeopleInGroup) - 6 , ((screenHeight - 64) / 5) / 2)];
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *message = [NSString stringWithFormat:@"Are you sure that you want to delete %@", [[StudentController SharedInstance].students objectAtIndex:indexPath.row]];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:message delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
    
    self.arrayIndex = indexPath;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 4, 2, 4);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout maximumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1)
    {
        [[StudentController SharedInstance] removeStudent:self.arrayIndex.row];
        [self refreshData];
    }
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#pragma mark - Setup Navigation Bar

-(void)setupNavigationBar {

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                               target:self
                               action:@selector(AddNewStudent)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self setTitle:@"Random Groups"];
}

#pragma mark - Shuffle & Refresh Methods

-(void)setupToolBar {
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44)];
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                   target:self
                                   action:@selector(refresh)];
    UIBarButtonItem *groupsOfTwo = [[UIBarButtonItem alloc] initWithTitle:@"2"
                                 style: UIBarButtonItemStylePlain
                                 target:nil
                                 action:@selector(groupsOfTwo)];
    UIBarButtonItem *groupsOfThree = [[UIBarButtonItem alloc] initWithTitle:@"3"
                                   style: UIBarButtonItemStylePlain
                                   target:nil
                                   action:@selector(groupsOfThree)];
    UIBarButtonItem *groupsOfFour = [[UIBarButtonItem alloc] initWithTitle:@"4"
                                  style: UIBarButtonItemStylePlain
                                  target:nil
                                  action:@selector(groupsOfFour)];

    refreshButton.tintColor = [UIColor whiteColor];
    NSArray *arrayOfItems = @[flexibleItem, refreshButton, flexibleItem, groupsOfTwo, flexibleItem, groupsOfThree, flexibleItem, groupsOfFour, flexibleItem];
    [toolBar setItems:arrayOfItems];
    [self.view addSubview:toolBar];
}

-(void)groupsOfTwo {
    numberOfPeopleInGroup = 2;
    [self refreshData];
}

-(void)groupsOfThree {
    numberOfPeopleInGroup = 3;
    [self refreshData];
}

-(void)groupsOfFour {
    numberOfPeopleInGroup = 4;
    [self refreshData];
}

-(void)refresh{
    [self.modelController shuffle:[StudentController SharedInstance].students];
    [self refreshData];
}

-(void)refreshData {
    [self.collectionView reloadData];
}

-(void)AddNewStudent {
    [self.navigationController pushViewController: [NewStudentViewController new] animated:YES];
}

#pragma mark - Notification Center

-(void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:refreshNotification object:nil];
}

-(void)unregisterNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:studentKey object:nil];
}

-(void)dealloc {
    [self unregisterNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end