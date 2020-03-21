//
//  WordViewController.h
//  NextDictObjectiveC
//
//  Created by Hao Nguyen on 2020/03/28.
//  Copyright © 2020 Hao Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;

@property (strong, nonatomic) NSString *word;

@property (weak, nonatomic) IBOutlet WKWebView *wkWebView;

@end
