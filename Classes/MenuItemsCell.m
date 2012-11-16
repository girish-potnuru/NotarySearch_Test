//
//  MenuItemsCell.m
//  ApunKaBazar
//
//  Created by APPLE on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuItemsCell.h"


@implementation MenuItemsCell

@synthesize ItemName;
@synthesize Description;
@synthesize price;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
	
	NSLog(@"sample check");
	NSLog(@"sample check1");
	
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	
	[ItemName release];
	[Description release];
	[price release];
	
	
	
    [super dealloc];
}


@end
