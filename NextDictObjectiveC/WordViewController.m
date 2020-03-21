//
//  WordViewController.m
//  NextDictObjectiveC
//
//  Created by Hao Nguyen on 2020/03/28.
//  Copyright © 2020 Hao Nguyen. All rights reserved.
//

#import "WordViewController.h"
#import "FetchHelper.h"

@implementation WordViewController

NSArray *dataArray;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navBar.title = self.word;
  
  self.wkWebView.opaque = NO;
  self.wkWebView.backgroundColor = [UIColor clearColor];
  [self getWordData:self.word];
}

-(void) getWordData:(NSString *)keyword {
  if ([keyword length] == 0) {
    return;
  }
  
  NSString *escapedString = [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
  
  NSString *url = [NSString stringWithFormat:@"https://dict.nless.pro/api/dict/%@?type=envi", escapedString];
  [FetchHelper fetchData:url :^void(NSDictionary *resultJsonArray) {
    dataArray = [resultJsonArray objectForKey:@"data"];
    NSMutableString *html = [NSMutableString stringWithString:@"<head><link rel='stylesheet' href='style.css' type='text/css'><meta name='viewport' content='initial-scale=1.0'/></head>"];
    
    if ([dataArray count] == 0) {
      [html appendString:@"Nothing"];
      return;
    } else {
      for (id des in dataArray) {
        [html appendString:des];
        [html appendString:@"<hr />"];
      }
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self.wkWebView loadHTMLString:html baseURL:nil];
    }];
  }];
}

@end
