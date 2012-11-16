//
//  AddsObject.m
//  ApunKaBazar
//
//  Created by stellentmac1 on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddsObject.h"


@implementation AddsObject
@synthesize imageUrl;
@synthesize addImage;
@synthesize Description;
@synthesize DescriptionURl;
@synthesize tagValue;



-(void)dealloc
{
	[tagValue release];
	[DescriptionURl release];
	[Description release];
	[addImage release];
	[imageUrl release];
	[super dealloc];
	
}

@end
