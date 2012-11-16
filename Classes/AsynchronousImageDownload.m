//
//  AsynchronousImageDownload.m
//  CheckOut
//
//  Created by stellentmac2 on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsynchronousImageDownload.h"
#import "ASIFormDataRequest.h"

@implementation AsynchronousImageDownload

@synthesize elementNo;
@synthesize delegate;

@synthesize pictureURL;
@synthesize image;

@synthesize ASIRequest;

#pragma mark

- (void)dealloc
{
	if (self.ASIRequest) 
	{
		if ([self.ASIRequest isExecuting]||[self.ASIRequest isReady]) 
		{
			self.ASIRequest.delegate=nil;
			[self.ASIRequest cancel];
			//NSLog(@"request cancelled");
		}
		//[self.ASIRequest release];
	}
	[pictureURL release];
	[image release];
	//[ASIRequest release];
    [super dealloc];
}


- (void)startDownload
{
	NSString *urlString=self.pictureURL;
	
	if (urlString)
	{
		NSString *encodedURL=[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
		NSURL *url=[[NSURL alloc] initWithString:encodedURL];
		ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
		[request setDelegate:self];
		self.ASIRequest=request;
		[self.ASIRequest startAsynchronous];
		[url release];
	}
	
}

- (void)cancelDownload
{
	if (self.ASIRequest.delegate) 
	{
		self.ASIRequest.delegate=nil;
		[self.ASIRequest cancel];
	}
}


#pragma mark -
#pragma mark ASIFormDataRequest AsynchronousImageDownload

- (void) requestFinished:(ASIHTTPRequest *)request
{
	self.ASIRequest.delegate = nil;
	NSData *data = [request responseData];
	self.image=[UIImage imageWithData:data];
	[delegate appImageDidLoad:self.elementNo];
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
	self.ASIRequest.delegate = nil;
	[delegate appImageDidLoad:self.elementNo];
}


@end
