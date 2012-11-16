//
//  ApunKaBazarAppDelegate.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<CoreLocation/CoreLocation.h>
#import "Category.h"
#import "MyCLController.h"
#import"ASIFormDataRequest.h"


@class HomeViewController;
@class LoginViewController;
@interface ApunKaBazarAppDelegate : NSObject <UIApplicationDelegate,CLLocationManagerDelegate,MyCLControllerDelegate> {
    UIWindow *window;
	
	UINavigationController *navController;
	
	HomeViewController *homeViewController;
	
	LoginViewController *loginViewController;
	
	NSString *username;
	
	NSString *FoodQualityRating;
	NSString *AtmosphereRating;
	NSString *ValueRating;
	NSString *ServiceRating;
	NSString *comment;
	NSMutableString *TermsFromPage;
	Category *selectedCategory;
	BOOL IsWriteReviewPage;
	NSString *CompleteRating;
	int checkBoxPressed;
	MyCLController *locationController;
	CLLocationCoordinate2D currentLocation;
	NSMutableArray *addImagesArray;
   UIImageView *splashView;	
	UIActivityIndicatorView *spinner;
	ASIFormDataRequest *asiRequest;
	NSMutableArray *ImagesconvertingArray;
	int count;
	NSTimer *addsTimer;
	
 
	
}
@property(nonatomic,retain)NSTimer *addsTimer;
@property(nonatomic,readwrite)int count;
@property(nonatomic,retain)	NSMutableArray *ImagesconvertingArray;
@property(nonatomic,retain)ASIFormDataRequest *asiRequest;
@property(nonatomic,retain)UIImageView *splashView;
@property(nonatomic,retain)UIActivityIndicatorView *spinner;
@property(nonatomic,retain)	NSMutableArray *addImagesArray;
@property(nonatomic,retain)MyCLController *locationController;
@property(nonatomic,readwrite)CLLocationCoordinate2D currentLocation;
@property(nonatomic,retain)	NSMutableString *TermsFromPage;
@property(nonatomic,readwrite)int checkBoxPressed;
@property(nonatomic,readwrite)BOOL IsWriteReviewPage;
@property(nonatomic,retain)NSString *CompleteRating;
@property(nonatomic,retain)NSString *comment;
@property(nonatomic,retain)NSString *FoodQualityRating;
@property(nonatomic,retain)NSString *AtmosphereRating;
@property(nonatomic,retain)NSString *ValueRating;
@property(nonatomic,retain)NSString *ServiceRating;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) HomeViewController *homeViewController;
@property (nonatomic, retain) LoginViewController *loginViewController;

@property (nonatomic, retain) NSString *username;

@property (nonatomic, retain) Category *selectedCategory;

-(void)createAdd;

 
@end

