//
//  RestaurantDetailViewController.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "ReviewsPageViewController.h"
#import "Restaurant.h"
#import "ASIFormDataRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "RestaurantMenuViewController.h"
#import "MapViewController.h"
#import "ApunKaBazarAppDelegate.h"
#import"Category.h"
#import"Facility.h"
#import "WebsiteViewController.h"
#import"AddsObject.h"
#import"AddsWebViewController.h"


@interface RestaurantDetailViewController()

- (void) updateRatingGiven: (int) rating;

@end


@implementation RestaurantDetailViewController

@synthesize facilityImageRequests;
@synthesize imgView;
@synthesize lblAddress;
@synthesize lblPhoneno;
@synthesize tblView;
@synthesize thisRestaurant;
@synthesize lblDistance;
@synthesize ImageScrollView;
@synthesize menuItemName;
@synthesize menuNameLabel;
@synthesize star1;
@synthesize star2;
@synthesize star3;
@synthesize star4;
@synthesize star5;
@synthesize EmailLabel;
@synthesize WebSiteLabel;
@synthesize AddImageView;
@synthesize addsTimer;
@synthesize count;

@synthesize otherImage1;
@synthesize otherImage2;
@synthesize otherImage3;
@synthesize activityIndicator;
@synthesize deScriptionLabel;
@synthesize Addbutton;


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

- (IBAction) openWebsite: (id) sender
{
	WebsiteViewController *viewController = [[WebsiteViewController alloc] initWithNibName:@"WebsiteViewController" bundle:nil];
	[viewController setWebUrl:thisRestaurant.WebSiteUrl];
	[self.navigationController pushViewController:viewController animated:YES];
	//[viewController release];
}

- (IBAction) callNow: (id) sender
{
	NSString *phonePref;
	phonePref=@"tel://";
	
	NSString *phoneUrl;
	phoneUrl=[phonePref stringByAppendingFormat:@"%@",thisRestaurant.phoneno];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneUrl]];
	
}

- (IBAction) emailNow: (id) sender
{
	NSString *messageText=@"";//[NSString stringWithFormat:@"Name: %@\nPhone: %@\nYear/Make: %@\nModel: %@\nVIN: %@\nService: %@\nDate Time: %@\n",sName,sPhone,sMake,sModel,sMiles,sService,sAptDateTime];
	
	if ([MFMailComposeViewController canSendMail]) 
	{
		MFMailComposeViewController *mailView= [[MFMailComposeViewController alloc] init];
		mailView.mailComposeDelegate=self;
		//mailView.navigationBar.tintColor=[UIColor colorWithRed:144/255.0 green:89/255.0 blue:34/255.0 alpha:1];
		//mailView.navigationBar.tintColor=[UIColor colorWithRed:73/255.0 green:143/255.0 blue:168/255.0 alpha:1];
		[mailView setSubject:@""];
		[mailView setToRecipients:[NSArray arrayWithObject:thisRestaurant.Email]]; //[NSArray arrayWithObject:appDelegate.mechanicEmail]];
		[mailView setMessageBody:messageText isHTML:NO];
		[self presentModalViewController:mailView animated:YES];
		//[mailView release];
	}
	else 
	{
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"This device is not configured to send email" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}
}


//mailcomposer delelgate method
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
	
	if (result==MFMailComposeResultSent) 
	{
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Message was sent successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	appDelegate=(ApunKaBazarAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.navigationItem.title = thisRestaurant.resCategory;
	self.tblView.backgroundColor = [UIColor clearColor];
	self.activityIndicator.hidesWhenStopped = YES;
	
	
	// Start Loading images for Facilitites
	[self performSelector:@selector(createCategoryImages) withObject:nil afterDelay:0.1];
	
	
	// Start loading image for imgView
	[self.activityIndicator startAnimating];
	imgRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:thisRestaurant.imageURL]];
	imgRequest.delegate = self;
	[imgRequest startAsynchronous];
	
	
	// Set the Rating stars
	if (thisRestaurant.rating) 
	{
		int rating = 0;
		float ratingFloat = [thisRestaurant.rating floatValue];
		rating = round(ratingFloat);
		[self updateRatingGiven:rating];
	}
	
	else 
	{
		[self updateRatingGiven:0];
	}
	
	// Update Distance
	float dis = [thisRestaurant.resDistance floatValue];
	self.lblDistance.text = [NSString stringWithFormat:@"%0.2f mi",dis];
	
	if([thisRestaurant.address length]>1)
	{
	// Update Address String
	NSArray *array=[thisRestaurant.address componentsSeparatedByString:@","];
	NSLog(@"array is %@",array);
	
	NSMutableString *string1=[[NSMutableString alloc]init];
	NSMutableString *string3=[[NSMutableString alloc]init];
	for(int i=0;i<[array count];i++)
	{  
		if(i<[array count]-2)
		{
		    NSString *stringe=[array objectAtIndex:i];
		    [string3 appendString:stringe];
			[string3 appendString:@","];
			if(i==0)
			{
				[string3 appendString:@"\n"];
			}
		}
		else
		{
			NSString *stringes=[array objectAtIndex:i];
			[string1 appendString:stringes];
			[string1 appendString:@"-"];
		}
	}
	
	[string3 appendString:string1];
	int lenght=[string3 length];
	
	NSString *finalString3=[string3 substringToIndex:lenght-1];
	[string1 release];
	[string3 release];
		self.lblAddress.text =finalString3;
		
	}
	else {
		self.lblAddress.text =@"";
	}

	
	// Update other values
	self.menuNameLabel.text = thisRestaurant.resname;
	
	self.lblPhoneno.text = [NSString stringWithFormat:@"Ph: %@",thisRestaurant.phoneno];
	self.EmailLabel.text = thisRestaurant.Email;
	self.WebSiteLabel.text = thisRestaurant.WebSiteUrl;
	[self addImagesMethod];
}


-(void)createCategoryImages
{
	//Category *categoryObject=[[Category alloc]init];
	NSLog(@"thisRestaurant.FacilitiesArray Images,count is %d",[thisRestaurant.FacilitiesArray count]);
	
	int X=0;
	for(int i=0;i<[thisRestaurant.FacilitiesArray count];i++)
	{
		Facility *facility=[thisRestaurant.FacilitiesArray objectAtIndex:i];
		
		UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(X,0,25,25)];
		NSString *imageUrl=[facility valueForKey:@"facilityImgURL"];
		NSLog(@"image URL is %@",imageUrl);
		NSURL *URLS=[NSURL URLWithString:imageUrl];
		
		NSData *data=[NSData dataWithContentsOfURL:URLS];
		
		UIImage *image=[UIImage imageWithData:data];
		[imageview setImage:image];
		[self.ImageScrollView addSubview:imageview];
		[imageview release];
		
		X=X+30;
		
	}
	
	[self.ImageScrollView setContentSize:CGSizeMake(X,28)];
	
	[self.activityIndicator stopAnimating];
}


-(void)viewWillAppear:(BOOL)animated
{
	
	NSLog(@"RestaurantDetailViewController");	
	self.addsTimer=[NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(addImagesMethod) userInfo:nil repeats:YES];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex 
{
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] autorelease];
		
		UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(5, 5, 280, 40)];
		btn.tag=indexPath.section;
		[btn setImage:[UIImage imageNamed:@"items-bg.png"] forState:UIControlStateNormal];
		[btn addTarget:self action:@selector(menuClicked:) forControlEvents:UIControlEventTouchUpInside];
		
		[cell.contentView addSubview:btn];
		[btn release];
		
		UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 12, 268, 21)];
		itemLabel.textAlignment=UITextAlignmentCenter;
		itemLabel.textColor=[UIColor blueColor];
		itemLabel.backgroundColor = [UIColor clearColor];
		
		if(indexPath.section==0)
		{
			itemLabel.text=appDelegate.selectedCategory.specialitiesName;
		}
		else if(indexPath.section==1)
		{
			itemLabel.text=@"Review";	
		}
		else if(indexPath.section==2)
		{
			itemLabel.text=@"Map";	
		}
		
		[cell.contentView addSubview:itemLabel];
		[itemLabel release];
		
		cell.backgroundColor = [UIColor clearColor];
	}
	
	
	cell.selectionStyle=UITableViewCellSelectionStyleNone;
	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	NSLog(@"Did Select Row");
}


- (void) menuClicked: (id) sender
{
	UIButton *btn = (UIButton *)sender;
	
	if (btn.tag == 0) 
	{
		RestaurantMenuViewController *menuviewcontroller=[[RestaurantMenuViewController alloc]initWithNibName:@"RestaurantMenuViewController" bundle:nil];
		menuviewcontroller.rsid=thisRestaurant.resid;
		NSLog(@"rsid is %@",menuviewcontroller.rsid);
		[self.navigationController pushViewController:menuviewcontroller animated:YES];
		//[menuviewcontroller release];
	}
	else if (btn.tag == 1)
	{
		ReviewsPageViewController *reviewsPage = [[ReviewsPageViewController alloc] initWithNibName:@"ReviewsPageViewController" bundle:nil];
		[reviewsPage setValue:thisRestaurant forKey:@"thisRestaurant"];
		[reviewsPage setValue:menuItemName forKey:@"menuItemName"];
		[self.navigationController pushViewController:reviewsPage animated:YES];
		//[reviewsPage release];
	}
	else if (btn.tag == 2)
	{
		MapViewController *mapPage = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
		[mapPage setValue:thisRestaurant forKey:@"thisRestaurant"];
		[self.navigationController pushViewController:mapPage animated:YES];
		//[mapPage release];
	}
}


- (void) requestFinished:(ASIHTTPRequest *)request
{
	NSData *imgData = [request responseData];
	UIImage *image = [UIImage imageWithData:imgData];
	if(image)
	{
	CALayer *imgLayer = [CALayer layer];
	imgLayer.frame = CGRectMake(0, 0, self.imgView.frame.size.width, self.imgView.frame.size.height);
	imgLayer.contents = (id)image.CGImage;
	[self.imgView.layer addSublayer:imgLayer];
	self.imgView.layer.cornerRadius = 5.0;
	}else 
	{
		self.imgView.image=[UIImage imageNamed:@"no-image.png"];
		
	}

	
	imgRequest.delegate = nil;
	imgRequest = nil;
	
	[self.activityIndicator stopAnimating];
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
	imgRequest.delegate = nil;
	imgRequest = nil;
	[self.activityIndicator stopAnimating];
}

- (void) updateRatingGiven: (int) rating
{
	for (int i = 1; i <= rating; i++) 
	{
		UIImageView *star = (UIImageView *)[self.view viewWithTag:i];
		[star setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
		
	}
}

-(IBAction)backClicked:(id) sender
{
	[self.navigationController popViewControllerAnimated:YES];
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

/*
-(void)addImagesMethod
{
	if(![appDelegate.addImagesArray count]==0)
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
	
}
 */

-(void)viewDidDisappear:(BOOL)animated
{
	count=0;
	[self.addsTimer invalidate];
}

/*

-(void) getData:(NSString *)imageUrl
{
	
	NSURL *url1=[[NSURL alloc] initWithString:imageUrl];
	asiRequest = [ASIFormDataRequest requestWithURL:url1];
	NSLog(@"category id is %@",appDelegate.selectedCategory.categotyId);
	[asiRequest setDelegate:self];
	[asiRequest startAsynchronous];
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
	
	NSDictionary *results = [responseString JSONValue];
	
	NSArray *array=[results objectForKey:@"menus"];
	
	NSMutableArray *arr=[[NSMutableArray alloc] init];
	
	for (NSDictionary *dict in array) 
	{
		CategoryMenu *menu=[[CategoryMenu alloc] init];
		menu.categoryMenuid=[dict objectForKey:@"menuid"];
		menu.categoryMenuname=[dict objectForKey:@"menuname"];
		[arr addObject:menu];
		[menu release];
	}
	
	[self.menuArray removeAllObjects];
	self.menuArray=arr;
	
	NSLog(@"array count is %d,%d,%d",[self.menuArray count],[arr count],[array count]);
	[arr release];
	[self.tblView reloadData];
	[self.activityIndicator stopAnimating];
	
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
	asiRequest.delegate = nil;
	asiRequest = nil;
	
	[self.activityIndicator stopAnimating];
}

*/

-(void)addImagesMethod
{
	
	if(count<[appDelegate.addImagesArray count])
	{
		
		int tagvalue;
		NSLog(@"addimages countis %d",[appDelegate.addImagesArray count]);
		self.deScriptionLabel.text=@"";
		AddsObject *object=(AddsObject *)[appDelegate.addImagesArray objectAtIndex:count];		
		/*
		 NSString *url=object.imageUrl;
		 NSURL *urls=[NSURL URLWithString:url];
		 NSData *data=[NSData dataWithContentsOfURL:urls];
		 UIImage *image=[UIImage imageWithData:data];
		 self.AddImageView.image=image;
		 */
		self.AddImageView.image=object.addImage;
		
		
		tagvalue=[[NSString stringWithFormat:@"%@",object.tagValue]intValue];
		
		NSLog(@"tag value is %d",tagvalue);
		
		
		if(count<[appDelegate.ImagesconvertingArray count])
		{
			
			//if(count>1&&(count<[appDelegate.ImagesconvertingArray count]))
			{
				AddsObject *object1=(AddsObject *)[appDelegate.ImagesconvertingArray objectAtIndex:tagvalue];
				
				Addbutton.tag=tagvalue;
				self.deScriptionLabel.text=object1.Description;
				
				NSLog(@"descriptionlabel is %@",object1.Description);
			}
			
			/*
			 else 
			 
			 {
			 AddsObject *object1=(AddsObject *)[appDelegate.ImagesconvertingArray objectAtIndex:0];
			 
			 self.deScriptionLabel.text=object1.Description;
			 
			 NSLog(@"descriptionlabel is %@",object1.Description);
			 
			 
			 }
			 */ 
			
			
		}	
		
		count++;
		
		
		
	}	
    
	else	
	{
		count=0;
		
	}
	
	NSLog(@"count is %d",count);
	
}

-(IBAction)ADDPressed:(id)sender
{
	
	NSLog(@"sender tag is %d",[sender tag]);
	if([appDelegate.ImagesconvertingArray count]>0)
	{

	AddsWebViewController *addswebviewc=[[AddsWebViewController alloc]initWithNibName:@"AddsWebViewController" bundle:nil];
	AddsObject *object1=(AddsObject *)[appDelegate.ImagesconvertingArray objectAtIndex:[sender tag]];
	addswebviewc.webUrlString=object1.DescriptionURl;
	NSLog(@"weburl string is %@,%@",object1.DescriptionURl,addswebviewc.webUrlString);
	[self.navigationController pushViewController:addswebviewc animated:YES];
	}
	
	
}


- (void)dealloc 
{
	if (imgRequest) 
	{
		imgRequest.delegate = nil;
		[imgRequest cancel];
		imgRequest = nil;
	}
	
		[AddImageView release];
	[thisRestaurant release];
	
	[facilityImageRequests release];
	
	[lblDistance release];
	lblDistance = nil;
	
	[imgView release];
	imgView = nil;
	[lblAddress release];
	lblAddress = nil;
	[lblPhoneno release];
	lblPhoneno = nil;
	
	[menuItemName release];
	[menuNameLabel release];
	menuNameLabel = nil;
	
	[tblView release];
	tblView = nil;
	
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
	[EmailLabel release];
	EmailLabel=nil;
    [WebSiteLabel release];
	WebSiteLabel=nil;
	
	[otherImage1 release];
	otherImage1 = nil;
	[otherImage2 release];
	otherImage2 = nil;
	[otherImage3 release];
	otherImage3 = nil;
	
	[activityIndicator release];
	activityIndicator = nil;
    [super dealloc];
}


@end
