//
//  RestaurantMenu.h
//  ApunKaBazar
//
//  Created by APPLE on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RestaurantMenu : NSObject {
	NSString *menuid;
	NSString *menuname;
	NSString *ItemId;
	NSString *ItemName;
	NSString *ItemDescrption;
	NSString *ItemPrice;

}
@property(nonatomic,retain)NSString *ItemPrice;
@property(nonatomic,retain)NSString *ItemDescrption;
@property(nonatomic,retain)NSString *ItemName;
@property(nonatomic,retain)NSString *ItemId;
@property(nonatomic,retain)NSString *menuid;
@property(nonatomic,retain)NSString *menuname;

@end
