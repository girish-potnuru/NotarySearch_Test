//
//  AddsObject.h
//  ApunKaBazar
//
//  Created by stellentmac1 on 7/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AddsObject : NSObject
{
	
	NSString *imageUrl;
	UIImage *addImage;
	NSString *Description;
	NSString *DescriptionURl;
	NSString *tagValue;

}
@property(nonatomic,retain)NSString *tagValue;
@property(nonatomic,retain)NSString *Description;
@property(nonatomic,retain)NSString *DescriptionURl;
@property(nonatomic,retain)UIImage *addImage;
@property(nonatomic,retain)NSString *imageUrl;

@end
