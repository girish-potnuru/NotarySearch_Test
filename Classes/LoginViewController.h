//
//  LoginViewController.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"TermsAndReviewsViewController.h"

@class SignUpViewController;
@class ForgotPasswordViewController;
@class ApunKaBazarAppDelegate;


@interface LoginViewController : UIViewController <UITextFieldDelegate>
{

	ApunKaBazarAppDelegate *appDelegate;
	TermsAndReviewsViewController *termsReviewViewController;
	SignUpViewController *signUpViewController;
	ForgotPasswordViewController *forgotpasswordViewController;
	UITextField *userId;
	UITextField *passWord;
	UITextField *currTextField;
	UINavigationBar *navibr;
}

@property(nonatomic,retain)TermsAndReviewsViewController *termsReviewViewController;
@property(nonatomic,retain)IBOutlet UINavigationBar *navibr;
@property (nonatomic, retain) SignUpViewController *signUpViewController;
@property (nonatomic, retain) ForgotPasswordViewController *forgotpasswordViewController;
@property (nonatomic, retain) IBOutlet UITextField *userId;
@property (nonatomic, retain) IBOutlet UITextField *passWord;
@property (nonatomic,retain) UITextField *currTextField;

- (IBAction) submitClicked:(id) sender;
- (IBAction) registerClicked:(id) sender;
- (IBAction) forgotPasswordClicked: (id) sender;
- (IBAction) loginAsGuestClicked: (id) sender;

@end
