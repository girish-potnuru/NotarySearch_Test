//
//  MenuItemsViewController.m
//  ApunKaBazar
//
//  Created by APPLE on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuItemsViewController.h"
#import "MenuItemsCell.h"
#import "JSON.h"
#import "ASIFormDataRequest.h"
#import "RestaurantMenu.h"
#import"AddsObject.h"
#import"ApunKaBazarAppDelegate.h"
@implementation MenuItemsViewController
@synthesize ItemId;
@synthesize ItemName;
@synthesize ItemTable;
@synthesize ItemArray;
@synthesize ItemCell;
@synthesize  total;
@synthesize titleline;
@synthesize activityIndicator;
@synthesize addsTimer;
@synthesize count;
@synthesize AddImageView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
-(void)viewWillAppear:(BOOL)animated
{
	
	NSLog(@"Menu Items View Controller");
	self.addsTimer=[NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(addImagesMethod) userInfo:nil repeats:YES];

}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	appDelegate=(ApunKaBazarAppDelegate *)[[UIApplication sharedApplication]delegate];

	ItemArray=[[NSMutableArray alloc]init];
	self.titleline.text=self.ItemName;
	self.titleline.textColor=[UIColor blueColor];
	[self.titleline setFont:[UIFont boldSystemFontOfSize:17]];
	self.titleline.textAlignment=UITextAlignmentCenter;
	
	activityIndicator.hidesWhenStopped = YES;
	[activityIndicator startAnimating];
	[self performSelector:@selector(getData) withObject:nil afterDelay:0.1];
	[self addImagesMethod];
}


-(IBAction)back
{
	[self.navigationController popViewControllerAnimated:YES];	
}

-(void) getData
{
	
	//http:www.myappdemo.com/ApunKaBazaar/services/getresmenudetails.php?resid=2
	NSString *urlString1=[NSString stringWithFormat:@"%@getresmenuitems.php",URLprefix];
	NSLog(@"%@",urlString1);
	NSURL *url1=[[NSURL alloc] initWithString:urlString1];
	asiRequest = [ASIFormDataRequest requestWithURL:url1];
	
	[asiRequest setPostValue:self.ItemId forKey:@"rmenuid"];
	NSLog(@"------id:%@",self.ItemId);
	[asiRequest setDelegate:self];
	[asiRequest startSynchronous];
	
	[url1 release];
	
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
	asiRequest.delegate = nil;
	asiRequest = nil;
	
	NSString *response = [request responseString];
	NSLog(@"response:%@",response);
	NSData *responseData=[request responseData];
	NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	
	NSLog(@"responce string is %@",responseString);
	
	NSArray *results=[responseString JSONValue];
	for(int i=0;i<[results count];i++)
	{
		NSDictionary *Dict=[results objectAtIndex:i];
		RestaurantMenu *menu=[[RestaurantMenu alloc]init];
		menu.ItemId=[Dict objectForKey:@"ItemId"];
		menu.ItemName=[Dict objectForKey:@"ItemName"];
		menu.ItemPrice=[Dict objectForKey:@"Price"];
		menu.ItemDescrption=[Dict objectForKey:@"Description"];
		
		[ItemArray addObject:menu];
		[menu release];
		
	}
	
	[self.ItemTable reloadData];
	[self.activityIndicator stopAnimating];
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
	asiRequest.delegate = nil;
	asiRequest = nil;
	
	[self.activityIndicator stopAnimating];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
	
	return [self.ItemArray count];
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 75;
}
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	RestaurantMenu *menu=[ItemArray objectAtIndex:indexPath.row];

	NSString *cellText=menu.ItemDescrption;
	UIFont *cellFont=[UIFont fontWithName:@"Helvetica" size:14.0];
	CGSize constraintSize=CGSizeMake(250,MAXFLOAT);
	CGSize txtViewSize=[cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
	return txtViewSize.height+30;
	
	
	
						
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 

{
	
	
	
	static NSString *MyIdentifier= @"MyIdentifier";
	MyIdentifier = @"MenuItemsCell";
	
	MenuItemsCell *cell = (MenuItemsCell *) [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	if (cell==nil) 
	{
		[[NSBundle mainBundle] loadNibNamed:@"MenuItemCell" owner:self options:nil];
		cell=ItemCell;
		
	}	
		
/*	MenuItemsCell *cell = (MenuItemsCell *)[tableView dequeueReusableCellWithIdentifier:@"MenuItemsCell"];
	
	if (cell == nil) 
	{
		[[NSBundle mainBundle] loadNibNamed:@"MenuItemsCell" owner:self options:nil];
		cell =ItemCell;
	}*/
	
	RestaurantMenu *menu=[ItemArray objectAtIndex:indexPath.row];
	
	
	 if(!([menu.ItemName isKindOfClass:[NSNull class]]||[menu.ItemName isEqualToString:@"null"]||menu.ItemName==nil))
	{
		
		cell.ItemName.text=menu.ItemName;
		cell.ItemName.textColor=[UIColor blueColor];
	}
		
     if([menu.ItemDescrption isKindOfClass:[NSNull class]]||[menu.ItemDescrption isEqualToString:@"null"]||menu.ItemDescrption==nil)
	 {
		
	 }
	
	else {
		
		 NSString *cellText=menu.ItemDescrption;
		 cell.Description.textColor=[UIColor blackColor];
		 UIFont *cellFont=[UIFont fontWithName:@"Helvetica" size:14.0];
		 CGSize constraintSize=CGSizeMake(250,MAXFLOAT);
		 CGSize txtViewSize=[cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
		 cell.Description.numberOfLines=0;
		 cell.Description.lineBreakMode = UILineBreakModeWordWrap;
		 cell.Description.frame = CGRectMake(15,30,280,txtViewSize.height);
		 cell.Description.text=menu.ItemDescrption;
		 
	 }		

	 if(!([menu.ItemPrice isKindOfClass:[NSNull class]]||[menu.ItemPrice isEqualToString:@"null"]||menu.ItemPrice==nil))
	{
		total=[menu.ItemPrice floatValue];
		cell.price.text=[NSString stringWithFormat:@"$%0.2f",total];
		cell.price.textColor=[UIColor blueColor];
		
	}
		
	//[cell.Description setNumberOfLines:2];

	return cell;
}
	
	

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)HomeButtonPressed:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
	
}

-(void)addImagesMethod
{
	
	if(count<[appDelegate.addImagesArray count])
	{
		AddsObject *object=(AddsObject *)[appDelegate.addImagesArray objectAtIndex:count];	
        self.AddImageView.image=object.addImage;
		count++;
		
	}	
    
	else	
	{
		count=0;
		
	}
	
	NSLog(@"count is %d",count);
	
}
-(void)viewDidDisappear:(BOOL)animated
{
	
	[self.addsTimer invalidate];
}



- (void)dealloc 
{
	if (asiRequest) 
	{
		asiRequest.delegate = nil;
		[asiRequest cancel];
		asiRequest = nil;
	}
	
	[ItemId release];
	[ItemName release];
	[ItemTable release];
	[ItemArray release];
	
	[activityIndicator release];
	activityIndicator = nil;
	
    [super dealloc];
}


@end
