//
//  MyAnnotation.m
//  BayDeltaLive
//
//  Created by stellentmac1 on 11/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"

#import <MapKit/MapKit.h>

@implementation MyAnnotation

@synthesize image;

@synthesize longitude;
@synthesize latitude;
@synthesize title1;
@synthesize subTitle;
@synthesize annotationTag;


- (CLLocationCoordinate2D)coordinate
{
	
	CLLocationCoordinate2D myCoordinate;
	myCoordinate.longitude=[self.longitude doubleValue];
	myCoordinate.latitude=[self.latitude doubleValue];
	return myCoordinate;
	
}

- (void)dealloc
{
    [image release];
	[longitude release];
	[latitude release];
	[title1 release];
	[subTitle release];
    [super dealloc];
}

- (NSString *)title
{
	NSLog(@"In title method. TITLE: %@",self.title1);
    return self.title1;//self.title;
}

// optional
- (NSString *)subtitle
{
	NSLog(@"In subtitle method. SUbTITLE: %@",self.subTitle);
    return self.subTitle;//self.subTitle;
}


@end
