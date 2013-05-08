//
//  ViewController.m
//  CustomViewsDemo
//
//  Created by Snowmanzzz on 5/6/13.
//  Copyright (c) 2013 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    BOOL isEditingItem;
    
}


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [_table setDelegate:self];
    [_table setDataSource:self];
    _sampleDataArray = [[NSMutableArray alloc] init];
    
    _textInput = [[CustomTextInputViewController alloc] init];
    [_textInput setDelegate:self];
    isEditingItem = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addItem:(id)sender {
    [_textInput showCustomTextInputViewInView:self.view withText:@"" andWithTitle:@"Add new Item"];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_sampleDataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [[cell textLabel] setFont:[UIFont fontWithName:@"Georgia" size:15.0]];
    }
    [[cell textLabel] setText:[_sampleDataArray objectAtIndex:[indexPath row]]];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_textInput showCustomTextInputViewInView:self.view withText:[_sampleDataArray objectAtIndex:[indexPath row]] andWithTitle:@"Edit item"];
    isEditingItem = YES;
}

- (void)shouldAcceptTextChanges {
//    [_sampleDataArray addObject:[_textInput getText]];
//    [_table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
//    [_textInput closeTextInputView];
    if (!isEditingItem) {
        [_sampleDataArray addObject:[_textInput getText]];
        
    } else {
        NSUInteger t = [[_table indexPathForSelectedRow] row];
        [_sampleDataArray replaceObjectAtIndex:t withObject:[_textInput getText]];
        isEditingItem = NO;
    }
    [_table reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_textInput closeTextInputView];
}
- (void)shouldDismissTextChanges {
    [_textInput closeTextInputView];
}


@end
