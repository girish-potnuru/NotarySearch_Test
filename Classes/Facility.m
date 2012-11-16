//
//  Facility.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 7/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Facility.h"


@implementation Facility


@synthesize facilityName;
@synthesize facilityImgURL;

-(void)dealloc{

	[facilityName release];
	[facilityImgURL release];
	[super dealloc];
}


@end
