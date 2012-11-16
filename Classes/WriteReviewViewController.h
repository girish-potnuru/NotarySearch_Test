//
//  WriteReviewViewController.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import"WriteReviewViewCell.h"
#import"WriteReviewCommentCell.h"
#import"WriteReviewObject.h"
#import"ApunKaBazarAppDelegate.h"
#import"Restaurant.h"
@class Restaurant;
@class ASIFormDataRequest;
@interface WriteReviewViewController : UIViewController <ASIHTTPRequestDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIActionSheetDelegate,UIPickerViewDelegate>
{
			
		
	ASIFormDataRequest *reviewRequest;
	UITableView *WriteReviewTableView;
	NSMutableArray *ReviewArray;
	WriteReviewCommentCell *reviewCommentCell;
	WriteReviewViewCell *writereviewcell;
	UITextField *currTextField;
	NSMutableDictionary *writeReviewDictionary;
	WriteReviewObject *writereviewobject;
	NSMutableArray *FoodQualityRatingArray;
	NSMutableArray *AtmosphereRatingArray;
	NSMutableArray *valueRatingArray;
	NSMutableArray *ServiceRatingArray;

	ApunKaBazarAppDelegate *appDelegate;
	UITextView *sampleTextview;
	Restaurant *thisRestaurant; 
	int pickerMoved;
	int pickerSelected;
	
	
	
}
@property(nonatomic,retain)	Restaurant *thisRestaurant;
@property(nonatomic,retain)UITextView *sampleTextview;
@property(nonatomic,retain)NSMutableArray *ServiceRatingArray;
@property(nonatomic,retain)NSMutableArray *valueRatingArray;
@property(nonatomic,retain)NSMutableArray *AtmosphereRatingArray;
@property(nonatomic,retain)NSMutableArray *FoodQualityRatingArray;
@property(nonatomic,retain)WriteReviewObject *writereviewobject;
@property(nonatomic,retain)NSMutableDictionary *writeReviewDictionary;
@property(nonatomic,retain)UITextField *currTextField;
@property(nonatomic,retain)IBOutlet WriteReviewCommentCell *reviewCommentCell;
@property(nonatomic,retain)IBOutlet WriteReviewViewCell *writereviewcell;
@property(nonatomic,retain)IBOutlet UITableView *WriteReviewTableView;
@property(nonatomic,retain)NSMutableArray *ReviewArray;
-(IBAction) save: (id) sender;

-(IBAction) backClicked:(id) sender;
@end
