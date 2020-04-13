//
//  FirstViewController.m
//  NextDictObjectiveC
//
//  Created by Hao Nguyen on 2020/03/22.
//  Copyright © 2020 Hao Nguyen. All rights reserved.
//

#import "SearchViewController.h"
#import "WordViewController.h"
#import "FetchHelper.h"

@implementation SearchViewController

long tableRowNo;
NSArray *tableData;
NSTimer *searchTimer;

- (void)viewDidLoad {
  [super viewDidLoad];
  // dismiss keyboard when tap outside textField
  //  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
  //  [self.view addGestureRecognizer:tap];
  
  tableData = @[];
}

-(void) searchWord:(NSString *)keyword {
  if ([keyword length] == 0) {
    return;
  }
  
  NSString *escapedString = [keyword stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
  
  NSString *url = [NSString stringWithFormat:@"https://dict.nless.pro/api/dict/search?key=%@&type=envi", escapedString];
  [FetchHelper fetchData:url :^void(NSDictionary *resultJsonArray) {
    tableData = [resultJsonArray objectForKey:@"data"];
    if ([tableData count] == 0) {
      return;
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self.tableView reloadData];
    }];
  }];
}

- (IBAction)onSearchClick:(id)sender {
  tableData = @[];
  self.searchBox.text = @"";
  [self.tableView reloadData];
  
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert" message:@"This is an alert." preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
  
  [alert addAction:defaultAction];
  [self presentViewController:alert animated:YES completion:nil];
}

-(void)dismissKeyboard {
  [self.searchBox resignFirstResponder];
}

- (IBAction)onSearchBoxChanged:(UITextField *)sender {
  if (searchTimer != nil) {
    [searchTimer invalidate];
    searchTimer = nil;
  }
  
  if ([self.searchBox.text length] == 0) {
    tableData = @[];
    [self.tableView reloadData];
    return;
  }
  
  searchTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(searchTimerEnd:) userInfo: self.searchBox.text repeats: NO];
}

- (void) searchTimerEnd:(NSTimer *)timer {
  NSString *keyword = (NSString*)timer.userInfo;
  [self searchWord: keyword];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *simpleTableIdentifier = @"SimpleTableItem";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
  }
  cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  tableRowNo = indexPath.row;
  [tableView deselectRowAtIndexPath:indexPath animated: true];

  NSLog(@"%ld, %@", tableRowNo, tableData[tableRowNo]);
  
  UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  WordViewController *wordVC = [storyboard instantiateViewControllerWithIdentifier:@"WordViewController"];
  wordVC.word = tableData[tableRowNo];
  [self.navigationController pushViewController:wordVC animated:YES];
}
@end
