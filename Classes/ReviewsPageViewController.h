//
//  ReviewsPageViewController.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import"ApunKaBazarAppDelegate.h"

@class Restaurant;
@class ReviewCell;
@class HeaderCell;
@class ASIFormDataRequest;
@interface ReviewsPageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ASIHTTPRequestDelegate>
{
	NSMutableArray *tableArray;
	UITableView *tblView;
	ASIFormDataRequest *asiRequest;
	ASIFormDataRequest *imgRequest;
	NSString *menuItemName;
	UILabel *menuNameLabel;
	ReviewCell *reviewCell;
	HeaderCell *reviewHeaderCell;
	UIView *whiteBGView;
	UIImageView *adView;
	ApunKaBazarAppDelegate *appDelegate;
	Restaurant *thisRestaurant; 
	NSString *CompleteRating;
	UIImage *placeImage;
	NSMutableString *OrigiString;
	
}
@property(nonatomic,retain)NSMutableString *OrigiString;
@property (nonatomic, retain) UIImage *placeImage;
@property (nonatomic, retain) Restaurant *thisRestaurant; 
@property(nonatomic,retain)	NSString *CompleteRating;
@property (nonatomic, retain) NSMutableArray *tableArray;
@property (nonatomic, retain) IBOutlet UITableView *tblView;
@property (nonatomic, retain) NSString *menuItemName;
@property (nonatomic, retain) IBOutlet UILabel *menuNameLabel;
@property (nonatomic, retain) IBOutlet ReviewCell *reviewCell;
@property (nonatomic, retain) IBOutlet HeaderCell *reviewHeaderCell;
@property (nonatomic, retain) IBOutlet UIView *whiteBGView;

@property (nonatomic, retain) IBOutlet UIImageView *adView;

- (IBAction) writeReview:(id) sender;
-(IBAction) backClicked:(id) sender;

@end
