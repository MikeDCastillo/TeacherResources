//
//  NewStudentViewController.m
//  Teacher Resources
//
//  Created by Christian Monson on 3/11/15.
//  Copyright (c) 2015 PJayRushton. All rights reserved.
//

#import "NewStudentViewController.h"
#import "GroupController.h"
#import "RandomizedGroupsViewController.h"
#import "Member.h"
#import "UIColor+Category.h"

@interface NewStudentViewController () <UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITextField * name;
@property (nonatomic,strong) RandomizedGroupsViewController *viewController;
@end

@implementation NewStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewController = [RandomizedGroupsViewController new];
    
    [self setupNavigationBar];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.name = [[UITextField alloc]initWithFrame:CGRectMake(20, 90, self.view.frame.size.width - 40, 30)];
    [self.name setBorderStyle:UITextBorderStyleRoundedRect];
    
    [self.name setPlaceholder:@"Name"];
    [self.view addSubview:self.name];
    
    UIButton *doneBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.name.center.x - 50, 150 , 100, 40)];
    [doneBtn addTarget:self action:@selector(SaveData) forControlEvents:UIControlEventTouchUpInside];
    [doneBtn setBackgroundColor:[UIColor trBlueColor]];
    [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
    [doneBtn.layer setCornerRadius:10];
    
    [self.view addSubview:doneBtn];
    
    // Do any additional setup after loading the view.
}

-(void)SaveData
{
    if ([self.name text].length > 0) {
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:refreshNotification object:nil];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Needs a Name" message:@"Please add a name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

-(void)setupNavigationBar
{
    [self setTitle:@"Add Student"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
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