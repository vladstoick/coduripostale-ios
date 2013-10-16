//
//  StradaViewController.m
//  Coduri Poștale
//
//  Created by Vlad Stoica on 10/9/13.
//  Copyright (c) 2013 Vlad Stoica. All rights reserved.
//

#import "StradaViewController.h"
#import "StradaResultsViewController.h"
@interface StradaViewController ()

@end

@implementation StradaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.queryTextField setDelegate:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showResults"]){
        StradaResultsViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.querry = self.queryTextField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self performSegueWithIdentifier:@"showResults" sender:self];
    return NO;
}
@end
