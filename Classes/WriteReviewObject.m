//
//  WriteReviewObject.m
//  ApunKaBazar
//
//  Created by stellentmac1 on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WriteReviewObject.h"


@implementation WriteReviewObject
@synthesize  Name,FoodQuality, Atmosphere, Value,Service,TitleOfReview,YourReview,comment;

-(void)dealloc
{
	[comment release];
	[Name release];
	[FoodQuality release];
	[Atmosphere release];
	[Value release];
	[Service release];
	[TitleOfReview release];
	[YourReview release];
	[super dealloc];
}
@end
