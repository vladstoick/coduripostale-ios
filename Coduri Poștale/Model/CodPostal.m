//
//  CodPostal.m
//  Coduri Poștale
//
//  Created by Vlad Stoica on 10/9/13.
//  Copyright (c) 2013 Vlad Stoica. All rights reserved.
//

#import "CodPostal.h"
@implementation CodPostal
- (id) initWithStreetName:(NSString*) streetName andCod:(NSString*) cod{
    self = [super init];
    if(self){
        self.streetName = streetName;
        self.cod = cod;
    }
    return self;
}
+ (void)searchAfterStreetName:(NSString *)streetName completion:(void (^)(NSArray *results))completionBlock{
    NSString *URLString = @"http://openapi.ro/api/addresses.json?description=";
    URLString = [URLString stringByAppendingString:streetName];
    NSLog(@"%@",URLString);
    NSURL *URL = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,  NSData *data,  NSError *connectionError) {
                               NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                               NSDictionary *json;
                               json = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding]
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:nil];
                               NSMutableArray *results = [[NSMutableArray alloc] init];
                               for( NSDictionary *dictionary in json){
                                   CodPostal *codPostal = [[CodPostal alloc] initWithStreetName:[dictionary valueForKey:@"description"] andCod:[dictionary valueForKey:@"zip"]];
                                   [results addObject:codPostal];
                               }
                               completionBlock(results);
                           }];

}
@end
