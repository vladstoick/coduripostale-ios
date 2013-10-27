//
//  CodPostal.h
//   Poștale
//
//  Created by Vlad Stoica on 10/9/13.
//  Copyright (c) 2013 Vlad Stoica. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodPostal : NSObject
@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) NSString* streetName;
@property (strong, nonatomic) NSString* cod;
+ (void) searchAfterStreetName:(NSString*) streetName
                    completion:(void (^)(NSDictionary *results)) completionBlock;
@end
