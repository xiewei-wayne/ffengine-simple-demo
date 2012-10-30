//
//  InputVideoUrlViewController.h
//  ELPlayer
//
//  Created by Steven Jobs on 12-2-25.
//  Copyright (c) 2012年 xiewei.max@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputVideoUrlViewController : UITableViewController <UISearchBarDelegate>

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) NSMutableArray *urlHistory;

@end
