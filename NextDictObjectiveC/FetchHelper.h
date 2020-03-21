//
//  FetchHelper.h
//  NextDictObjectiveC
//
//  Created by Hao Nguyen on 2020/03/28.
//  Copyright © 2020 Hao Nguyen. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface FetchHelper : NSObject

+ (void)fetchData : (NSString *) url :(void(^)(NSDictionary*)) block;

@end
