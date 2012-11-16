//
//  RegisterCell.m
//  ApunKaBazar
//
//  Created by APPLE on 6/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RegisterCell.h"


@implementation RegisterCell
@synthesize titleOfLabel;
@synthesize fieldOfText;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
	{
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
