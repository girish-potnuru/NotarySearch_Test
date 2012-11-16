//
//  AsynchronousImageDownload.h
//  CheckOut
//
//  Created by stellentmac2 on 4/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AsynchronousImageDownloadDelegate;

@class ASIFormDataRequest;
@interface AsynchronousImageDownload : NSObject
{
    int elementNo;
	id <AsynchronousImageDownloadDelegate> delegate;
	NSString *pictureURL;
	UIImage *image;
	ASIFormDataRequest *ASIRequest;
}

@property (nonatomic, readwrite) int elementNo;
@property (nonatomic, assign) id <AsynchronousImageDownloadDelegate> delegate;
@property (nonatomic, retain) NSString *pictureURL;
@property (nonatomic, retain) UIImage *image;

@property (nonatomic, retain) ASIFormDataRequest *ASIRequest;

- (void)startDownload;
- (void)cancelDownload;

@end

@protocol AsynchronousImageDownloadDelegate 

- (void)appImageDidLoad:(int)element;

@end
