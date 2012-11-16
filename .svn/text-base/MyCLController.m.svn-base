//
//  MyCLController.m
//  PowerNearMe
//
//  Created by basanth alluri on 1/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyCLController.h"


@implementation MyCLController

@synthesize locationManager;
@synthesize delegate;

- (id) init {
    self = [super init];
    if (self != nil) {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self; // send loc updates to myself
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
	
	[self.delegate locationUpdate:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
	[self.delegate locationError:error];
//	CLLocation *newLocation;// = {latitude:17.734697,longitude:83.299386};
//	newLocation.coordinate.latitude= 17.734697;
//	newLocation.coordinate.longitude=83.299386;
//	[self.delegate locationUpdate:newLocation];
}

- (void)dealloc {
    [self.locationManager release];
    [super dealloc];
}



@end
