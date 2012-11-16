//
//  SearchViewController.h
//  ApunKaBazar
//
//  Created by stellentmac1 on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"CategoryMenuListCell.h"
#import"IconDownloader.h"
#import"ApunKaBazarAppDelegate.h"


@interface SearchViewController : UIViewController<IconDownloaderDelegate> {
	
	
	UISearchBar *searchBar;
	UITableView *SearchTableView;
	NSMutableArray *SearchArray;
    UIActivityIndicatorView *activityIndicator;
	NSMutableDictionary *imageDownloadsInProgress; 
	CategoryMenuListCell *tblCell;
	int count;
	NSTimer *addsTimer;
	UIImageView *AddImageView;
	ApunKaBazarAppDelegate *appDelegate;
	UILabel *TopLabel;
	
	
}
@property(nonatomic,retain)IBOutlet UILabel *TopLabel;
@property(nonatomic,retain)NSTimer *addsTimer;
@property(nonatomic,retain)IBOutlet UIImageView *AddImageView;
@property(nonatomic,readwrite)	int count;
@property(nonatomic,retain)IBOutlet CategoryMenuListCell *tblCell;
@property(nonatomic,retain)	NSMutableDictionary *imageDownloadsInProgress; 
@property(nonatomic,retain)IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,retain)	NSMutableArray *SearchArray;
@property(nonatomic,retain)IBOutlet UITableView *SearchTableView;
@property(nonatomic,retain)IBOutlet UISearchBar *searchBar;
-(IBAction)back:(id)sender;
-(IBAction)HomeButtonPressed:(id)sender;
@end
