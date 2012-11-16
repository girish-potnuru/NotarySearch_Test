//
//  CategoryMenuListCell.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CategoryMenuListCell.h"


@implementation CategoryMenuListCell
@synthesize CategoryLabel;
@synthesize lblName;
@synthesize lblAddress;
@synthesize lblPhone;
@synthesize img;
@synthesize lblDistance;

@synthesize star1;
@synthesize star2;
@synthesize star3;
@synthesize star4;
@synthesize star5;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void) updateRating: (int) rating
{
	for (int i = 1; i <= rating; i++) 
	{
		UIImageView *star = (UIImageView *)[self viewWithTag:i];
		[star setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
	}
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc 
{
	[CategoryLabel release];
	CategoryLabel=nil;
	
	[lblName release];
	lblName = nil;
	[lblAddress release];
	lblAddress = nil;
	[lblPhone release];
	lblPhone = nil;
	[img release];
	img = nil;
	[lblDistance release];
	lblDistance = nil;
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
