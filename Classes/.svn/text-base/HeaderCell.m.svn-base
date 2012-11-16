//
//  HeaderCell.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HeaderCell.h"


@implementation HeaderCell

@synthesize placeName;
@synthesize placeAddress;
@synthesize placeDistance;
@synthesize placePh;

@synthesize placeImage;

@synthesize otherImage1;
@synthesize otherImage2;
@synthesize otherImage3;

@synthesize star1;
@synthesize star2;
@synthesize star3;
@synthesize star4;
@synthesize star5;

- (void) updateRatingGiven: (int) rating
{
	if (rating == 5) 
	{
		self.star1.alpha = 1.0;
		self.star2.alpha = 1.0;
		self.star3.alpha = 1.0;
		self.star4.alpha = 1.0;
		self.star5.alpha = 1.0;
	}
	else 
	{
		self.star5.alpha = 0.3;
		
		if (rating == 4) 
		{
			self.star1.alpha = 1.0;
			self.star2.alpha = 1.0;
			self.star3.alpha = 1.0;
			self.star4.alpha = 1.0;
			
		}
		else 
		{
			self.star4.alpha = 0.3;
			
			if (rating == 3) 
			{
				self.star1.alpha = 1.0;
				self.star2.alpha = 1.0;
				self.star3.alpha = 1.0;
				
			}
			else 
			{
				self.star3.alpha = 0.3;
				
				if (rating == 2) 
				{
					self.star1.alpha = 1.0;
					self.star2.alpha = 1.0;
					
				}
				else 
				{
					self.star1.alpha = 1.0;
					self.star2.alpha = 0.3;
				}
				
			}
			
		}
		
	}
	
}


- (void)dealloc 
{
	[placePh release];
	placePh = nil;
	[placeName release];
	placeName = nil;
	[placeAddress release];
	placeAddress = nil;
	[placeDistance release];
	placeDistance = nil;
	
	[placeImage release];
	placeImage = nil;
	
	[otherImage1 release];
	otherImage1 = nil;
	[otherImage2 release];
	otherImage2 = nil;
	[otherImage3 release];
	otherImage3 = nil;
	
	[star1 release];
	star1 = nil;
	[star2 release];
	star2 = nil;
	[star3 release];
	star3 = nil;
	[star4 release];
	star4 = nil;
	[star5 release];
	star5 = nil;
    [super dealloc];
}


@end
