//
//  ResultViewController.m
//  Coduri Poștale
//
//  Created by Vlad Stoica on 09/11/13.
//  Copyright (c) 2013 Vlad Stoica. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self.rezultat.sector isEqualToString:@""]){
        return 4;
    }
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"Tipul străzii";
    }
    if(section == 1){
        return @"Numele străzii";
    }
    if(section == 2){
        return @"Codul Poștal";
    }
    if(section == 3){
        return @"Județ";
    }
    if(section == 4){
        return @"Sector";
    }
    return @"Error";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CodResultCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if( indexPath.section == 0){
        cell.textLabel.text = self.rezultat.tipulStrazii;
    } else if(indexPath.section == 1){
        cell.textLabel.text = self.rezultat.streetName;
    } else if(indexPath.section == 2){
        cell.textLabel.text = self.rezultat.cod;
    } else if(indexPath.section == 3){
        cell.textLabel.text = self.rezultat.judet;
    } else {
        cell.textLabel.text = self.rezultat.sector;
    }
    return cell;
}


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
