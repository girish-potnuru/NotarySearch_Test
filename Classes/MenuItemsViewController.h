//
//  MenuItemsViewController.h
//  ApunKaBazar
//
//  Created by APPLE on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import"ApunKaBazarAppDelegate.h"

@class ASIFormDataRequest;
@class MenuItemsCell;
@interface MenuItemsViewController : UIViewController <ASIHTTPRequestDelegate>
{
	NSString *ItemId;
	NSString *ItemName;
	NSMutableArray *ItemArray;
	UITableView *ItemTable;
	MenuItemsCell *ItemCell;
	float total;
	UILabel *titleline;
	
	ApunKaBazarAppDelegate *appDelegate;
	ASIFormDataRequest *asiRequest;
	
	UIActivityIndicatorView *activityIndicator;
	UIImageView *AddImageView;
	NSTimer *addsTimer;
	int count;

	
	
	
}
@property(nonatomic,retain)IBOutlet UIImageView *AddImageView;
@property(nonatomic,retain)NSTimer *addsTimer;
@property(nonatomic,readwrite)int count;
@property(nonatomic,retain)IBOutlet UILabel *titleline;
@property(nonatomic,readwrite)float total;
@property(nonatomic,retain)IBOutlet MenuItemsCell *ItemCell;
@property(nonatomic,retain)IBOutlet UITableView *ItemTable;
@property(nonatomic,retain)NSMutableArray *ItemArray;
@property(nonatomic,retain)NSString *ItemId;
@property(nonatomic,retain)NSString *ItemName;
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *activityIndicator;

-(void) getData;
-(IBAction)back;
-(IBAction)HomeButtonPressed:(id)sender;
@end
