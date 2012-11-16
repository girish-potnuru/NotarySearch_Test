//
//  SignUpViewController.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterCell.h"
#import "ApunKaBazarAppDelegate.h"
#import "LoginObject.h"
#import"TermsAndReviewsViewController.h"


@interface SignUpViewController : UIViewController<UITextFieldDelegate> 
{

	
	UIActivityIndicatorView *spinner;
	RegisterCell *regCell;
	UITableView *tableView;
	ApunKaBazarAppDelegate *appDelegate;
	LoginObject *loginObject;
	int checkBoxPressed;
	UITextField *currentTextField;
	UIButton *checkButton;
	TermsAndReviewsViewController *termsAndReviewViewController;
	
	
}
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *spinner;

@property(nonatomic,retain)	TermsAndReviewsViewController *termsAndReviewViewController;
@property(nonatomic,retain)IBOutlet UIButton *checkButton;
@property (nonatomic, retain) IBOutlet RegisterCell *regCell;
@property (nonatomic,retain) IBOutlet UITableView *tableView;
@property (nonatomic,retain) LoginObject *loginObject;


- (IBAction) submitClicked: (id) sender;
- (IBAction) backClicked: (id) sender;
-(IBAction)CheckBoxButtonPressed:(id)sender;
-(IBAction)TermsAndConditionsButton:(id)sender;
@end
