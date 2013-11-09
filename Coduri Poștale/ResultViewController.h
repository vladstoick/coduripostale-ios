//
//  ResultViewController.h
//  Coduri Poștale
//
//  Created by Vlad Stoica on 09/11/13.
//  Copyright (c) 2013 Vlad Stoica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodPostal.h"
@interface ResultViewController : UITableViewController
@property (strong, nonatomic) CodPostal *rezultat;
@end
