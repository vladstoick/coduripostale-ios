//
//  CodPostal.m
//  Coduri Poștale
//
//  Created by Vlad Stoica on 10/9/13.
//  Copyright (c) 2013 Vlad Stoica. All rights reserved.
//

#import "CodPostal.h"
@implementation CodPostal
- (id) initWithStreetName:(NSString*) streetName andCod:(NSString*) cod andCity:(NSString*) city{
    self = [super init];
    if(self){
        self.streetName = streetName;
        self.cod = cod;
        self.city = city;
    }
    return self;
}
+ (void)searchAfterStreetName:(NSString *)streetName completion:(void (^)(NSDictionary *results))completionBlock{
    streetName = [streetName stringByReplacingOccurrencesOfString:@"ș" withString:@"s"];
    streetName = [streetName stringByReplacingOccurrencesOfString:@"Ș" withString:@"s"];
    streetName = [streetName stringByReplacingOccurrencesOfString:@"Ț" withString:@"t"];
    streetName = [streetName stringByReplacingOccurrencesOfString:@"ț" withString:@"t"];
    streetName = [streetName stringByReplacingOccurrencesOfString:@"Ă" withString:@"a"];
    streetName = [streetName stringByReplacingOccurrencesOfString:@"ă" withString:@"a"];
    streetName = [streetName stringByReplacingOccurrencesOfString:@"â" withString:@"a"];
    streetName = [streetName stringByReplacingOccurrencesOfString:@"Â" withString:@"a"];
    streetName = [streetName stringByReplacingOccurrencesOfString:@"î" withString:@"i"];
    streetName = [streetName stringByReplacingOccurrencesOfString:@"Î" withString:@"i"];
    NSString *URLString = @"http://openapi.ro/api/addresses.json?description=";
    streetName = [streetName stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
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
                               NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
                               for( NSDictionary *dictionary in json){
                                   CodPostal *codPostal = [[CodPostal alloc] initWithStreetName:[dictionary valueForKey:@"description"]
                                                                                         andCod:[dictionary valueForKey:@"zip"]
                                                                                        andCity:[dictionary valueForKey:@"location"]];
                                   if([results valueForKey:codPostal.city]){
                                       NSMutableArray *currentCodesForCity = [results valueForKey:codPostal.city];
                                       [currentCodesForCity addObject:codPostal];
                                   } else {
                                       NSMutableArray *currentCodesForCity = [[NSMutableArray alloc] initWithObjects:codPostal, nil];
                                       [results setValue:currentCodesForCity forKey:codPostal.city];
                                   }
                                
                               }
                               completionBlock(results);
                           }];

}
@end
