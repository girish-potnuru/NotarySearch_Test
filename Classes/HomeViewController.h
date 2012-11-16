//
//  HomeViewController.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsynchronousImageDownload.h"

@class ApunKaBazarAppDelegate;

@class CategoryMenuViewController;

@interface HomeViewController : UIViewController <AsynchronousImageDownloadDelegate>{

	ApunKaBazarAppDelegate *appDelegate;
	CategoryMenuViewController *categoryMenuViewController;
	UILabel *titleline;
	UIScrollView *scrollView;
	NSMutableDictionary *imageDownloadsInProgress;
	NSMutableArray *categoryArray;
	UIActivityIndicatorView *activityIndicator;
}

@property(nonatomic,retain)IBOutlet UILabel *titleline;
@property (nonatomic, retain) CategoryMenuViewController *categoryMenuViewController;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, retain) NSMutableArray *categoryArray;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;

- (void) clearScollView;
- (void) getData;
- (void) createScrollView;
- (IBAction) categoryClicked: (id) sender;
- (IBAction) backClicked: (id) sender;

@end
