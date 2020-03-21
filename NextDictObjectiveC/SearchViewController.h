//
//  FirstViewController.h
//  NextDictObjectiveC
//
//  Created by Hao Nguyen on 2020/03/22.
//  Copyright © 2020 Hao Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchBox;

@end

