//
//  ViewController.h
//  CustomViewsDemo
//
//  Created by Snowmanzzz on 5/6/13.
//  Copyright (c) 2013 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

- (IBAction)addItem:(id)sender;


@end
