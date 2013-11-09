//
//  StradaResultsViewController.m
//  Coduri Poștale
//
//  Created by Vlad Stoica on 10/9/13.
//  Copyright (c) 2013 Vlad Stoica. All rights reserved.
//

#import "StradaResultsViewController.h"
#import "CodPostal.h"
#import "SVProgressHUD.h"
#import "ResultViewController.h"
@interface StradaResultsViewController ()
@property NSDictionary *results;
@property NSArray *names;
@end

@implementation StradaResultsViewController

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
    [SVProgressHUD show];
    [CodPostal searchAfterStreetName:self.querry completion:^(NSDictionary *results) {
        self.results=results;
        NSMutableArray *names = [[NSMutableArray alloc] init];
        for(NSString *cityName in results){
            [names addObject:cityName];
        }
        self.names =[names sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *string1 = a;
            NSString *string2 = b;
            return [string1 compare:string2];
        }];
        [self.tableView reloadData];
        if(self.results.count >0){
            [SVProgressHUD dismiss];
        } else {
            [SVProgressHUD showErrorWithStatus:@"Niciun rezultat"];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.names.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *currentArrayForCod = [self.results objectForKey:self.names[section]];
    return currentArrayForCod.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSArray *currentArrayForCod = [self.results objectForKey:self.names[indexPath.section]];
    CodPostal *codpostal = [currentArrayForCod objectAtIndex:indexPath.row];
    cell.textLabel.text = codpostal.streetName;
    cell.detailTextLabel.text = codpostal.cod;
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.names[section];
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showResult"]){
        ResultViewController *destViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *currentArrayForCod = [self.results objectForKey:self.names[indexPath.section]];
        CodPostal *codpostal = [currentArrayForCod objectAtIndex:indexPath.row];
        destViewController.rezultat = codpostal;
    }
}



@end
