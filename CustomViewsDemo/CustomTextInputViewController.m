//
//  CustomTextInputViewController.m
//  CustomViewsDemo
//
//  Created by Snowmanzzz on 5/6/13.
//  Copyright (c) 2013 apple. All rights reserved.
//

#import "CustomTextInputViewController.h"

@interface CustomTextInputViewController () {
    CGFloat statusBarOffset;
}

- (void)keyboardWillShowNotification:(NSNotification *)notification;

@end

@implementation CustomTextInputViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_txtText setDelegate:self];
    [_txtText setInputAccessoryView:_toolbarIAV];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.66 green:0.66 blue:0.66 alpha:0.75]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showCustomTextInputViewInView:(UIView *)targetView withText:(NSString *)text andWithTitle:(NSString *)title {
    if (![[UIApplication sharedApplication] isStatusBarHidden]) {
        CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
        if (statusBarSize.width < statusBarSize.height) {
            statusBarOffset = statusBarSize.width;
        } else {
            statusBarOffset = statusBarSize.height;
        }
    } else {
        statusBarOffset = 0.0;
    }
CGFloat x, width, height;
if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft ||
    [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
    //TODO
    x = targetView.frame.origin.x - statusBarOffset;
    width = targetView.frame.size.height;
    height = targetView.frame.size.width;
} else {
    x = targetView.frame.origin.x;
    width = targetView.frame.size.width;
    height = targetView.frame.size.height;
}

//TODO
[self.view setFrame:CGRectMake(x, -height, width, height)];
[targetView addSubview:self.view];
[UIView beginAnimations:@"" context:nil];
[UIView setAnimationDuration:0.25];
[UIView setAnimationCurve:UIViewAnimationCurveLinear];
[self.view setFrame:CGRectMake(self.view.frame.origin.x, 0.0, self.view.frame.size.width, self.view.frame.size.height)];
[UIView commitAnimations];
[_txtText becomeFirstResponder];
[_txtText setText:text];
[_lblTitle setText:title];
}

- (void)closeTextInputView {
    [_txtText resignFirstResponder];
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, -self.view.frame.size.height, self.view
                                   .frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
    [self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.25];
}

- (NSString *)getText {
    return [_txtText text];
}

- (void)keyboardWillShowNotification:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGPoint keyboardOrigin = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin;
    CGFloat keyboardOriginY;
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft ||
        [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight) {
        keyboardOriginY = keyboardOrigin.x;
    } else {
        keyboardOriginY = keyboardOrigin.y;
    }
    
    [_txtText setFrame:CGRectMake(_txtText.frame.origin.x, keyboardOriginY - _txtText.frame.size.height - statusBarOffset
                                  , _txtText.frame.size.width, _txtText.frame.size.height)];
    
    // set the label's frame in turn
    [_lblTitle setFrame:CGRectMake(0.0, _txtText.frame.origin.y - _lblTitle.frame.size.height,
                                   _lblTitle.frame.size.width, _lblTitle.frame.size.height)];
}

- (IBAction)acceptTextChanges:(id)sender {
    [self.delegate shouldAcceptTextChanges];
}
- (void)cancelTextChanges:(id)sender {
   [self.delegate shouldDismissTextChanges];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.delegate shouldAcceptTextChanges];
}
@end
