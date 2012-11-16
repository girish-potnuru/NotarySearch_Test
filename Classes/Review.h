//
//  Review.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Review : NSObject 
{
	NSString *reviewId;
	NSString *reviewerName;
	NSString *reviewDate;	
	NSString *reviewTitle;
	NSString *reviewDesc;
	NSString *userRating;
	NSString *CompleteHotelRating;

	
}
@property(nonatomic,retain)NSString *reviewDate;	
@property(nonatomic,retain)NSString *userRating;
@property(nonatomic,retain)NSString *CompleteHotelRating;
@property (nonatomic, retain) NSString *reviewId;
@property (nonatomic, retain) NSString *reviewerName;
@property (nonatomic, retain) NSString *reviewTitle;
@property (nonatomic, retain) NSString *reviewDesc;

@end
