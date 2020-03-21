//
//  FetchHelper.m
//  NextDictObjectiveC
//
//  Created by Hao Nguyen on 2020/03/28.
//  Copyright © 2020 Hao Nguyen. All rights reserved.
//

#import "FetchHelper.h"

@implementation FetchHelper

+ (void)fetchData : (NSString *) url :(void(^)(NSDictionary*)) block {
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
  [request setHTTPMethod:@"GET"];
  [request setURL:[NSURL URLWithString:url]];
  
  [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSInteger statusCode = httpResponse.statusCode;
    if (statusCode != 200) {
      NSLog(@"Error getting %@, HTTP status code %li", url, statusCode);
      return;
    }
    
    NSError *parseError = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&parseError];
    
    if (error != nil) {
      NSLog(@"Error parsing JSON.");
      return;
    }
    
    [block copy];
    if (block)
      block(jsonArray);
    
  }] resume];
}

@end
