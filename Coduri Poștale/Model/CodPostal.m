//
//  CodPostal.m
//  Coduri Poștale
//
//  Created by Vlad Stoica on 10/9/13.
//  Copyright (c) 2013 Vlad Stoica. All rights reserved.
//

#import "CodPostal.h"
#import "AFNetworking.h"
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
    NSString *URLString =[@"http://openapi.ro/api/addresses.json?description=" stringByAppendingString:streetName];
    NSLog(@"%@",URLString);
    NSURL *URL = [NSURL URLWithString:URLString];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:URL];
    [httpClient getPath:@""
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    NSDictionary *json;
                    json = [NSJSONSerialization JSONObjectWithData:[responseStr dataUsingEncoding:NSUTF8StringEncoding]
                                                           options:NSJSONReadingMutableContainers
                                                             error:nil];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Recieved error %@",error);
                }];

//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]
//                                         initWithRequest:request];
//    operation.responseSerializer = [AFJSONSerializer serializer];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:nil];
//    [operation start];
}
@end
