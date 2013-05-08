//
//  CustomTextInputViewController.h
//  CustomViewsDemo
//
//  Created by Snowmanzzz on 5/6/13.
//  Copyright (c) 2013 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextInputViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextField *txtText;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbarIAV;

- (IBAction)acceptTextChanges:(id)sender;
- (IBAction)cancelTextChanges:(id)sender;

- (void)showCustomTextInputViewInView:(UIView *)targetView
                             withText:(NSString *)text
                         andWithTitle:(NSString *)title;

- (void)closeTextInputView;

- (NSString *)getText;

@end
