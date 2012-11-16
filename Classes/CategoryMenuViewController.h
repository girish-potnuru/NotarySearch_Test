//
//  CategoryMenuViewController.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ASIHTTPRequest.h"

@class ASIFormDataRequest;
@class CategoryMenuListViewController;
@class ApunKaBazarAppDelegate;
@interface CategoryMenuViewController : UIViewController <ASIHTTPRequestDelegate,UISearchBarDelegate>
{
	NSString *categoryId;
	NSString *categoryName;
	NSMutableArray *menuArray;
	UITableView *tblView;
	UILabel *titlehedline;
	UIActivityIndicatorView *activityIndicator;
	int count;
	NSTimer *addsTimer;
	UIImageView *AddImageView;

	CategoryMenuListViewController *categoryMenuListViewController;
	ApunKaBazarAppDelegate *appDelegate;
	ASIFormDataRequest *asiRequest;
	NSMutableArray *SearchedArray;
	UISearchBar *searchBar;
	
	UILabel *deScriptionLabel;
	UIButton *Addbutton;
	
	
	
	
}
@property(nonatomic,retain)IBOutlet UIButton *Addbutton;
@property(nonatomic,retain)IBOutlet UILabel *deScriptionLabel;
@property(nonatomic,retain)IBOutlet UISearchBar *searchBar;
@property(nonatomic,retain)NSMutableArray *SearchedArray;
@property(nonatomic,readwrite)int count;
@property(nonatomic,retain)NSTimer *addsTimer;
@property(nonatomic,retain)IBOutlet UIImageView *AddImageView;
@property (nonatomic, retain) IBOutlet UILabel *titlehedline;
@property (nonatomic, retain) NSString *categoryId;
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSMutableArray *menuArray;

@property (nonatomic, retain) IBOutlet UITableView *tblView;

@property (nonatomic, retain) CategoryMenuListViewController *categoryMenuListViewController;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void) getData;
- (IBAction) backClicked: (id) sender;
-(IBAction)HomeButtonPressed:(id)sender;
-(IBAction)ADDPressed:(id)sender;


@end
