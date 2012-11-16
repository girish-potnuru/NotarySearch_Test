//
//  HeaderCell.h
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HeaderCell : UITableViewCell 
{
	UILabel *placeName;
	UILabel *placeAddress;
	UILabel *placeDistance;
	UILabel *placePh;
	
	UIImageView *placeImage;
	
	UIImageView *otherImage1;
	UIImageView *otherImage2;
	UIImageView *otherImage3;
	
	UIImageView *star1;
	UIImageView *star2;
	UIImageView *star3;
	UIImageView *star4;
	UIImageView *star5;
}

@property (nonatomic, retain) IBOutlet UILabel *placeName;
@property (nonatomic, retain) IBOutlet UILabel *placeAddress;
@property (nonatomic, retain) IBOutlet UILabel *placeDistance;
@property (nonatomic, retain) IBOutlet UILabel *placePh;

@property (nonatomic, retain) IBOutlet UIImageView *placeImage;

@property (nonatomic, retain) IBOutlet UIImageView *otherImage1;
@property (nonatomic, retain) IBOutlet UIImageView *otherImage2;
@property (nonatomic, retain) IBOutlet UIImageView *otherImage3;

@property (nonatomic, retain) IBOutlet UIImageView *star1;
@property (nonatomic, retain) IBOutlet UIImageView *star2;
@property (nonatomic, retain) IBOutlet UIImageView *star3;
@property (nonatomic, retain) IBOutlet UIImageView *star4;
@property (nonatomic, retain) IBOutlet UIImageView *star5;

@end
