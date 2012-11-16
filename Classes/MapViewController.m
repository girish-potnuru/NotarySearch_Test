//
//  MapViewController.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "Restaurant.h"
#import "ASIFormDataRequest.h"
#import <QuartzCore/QuartzCore.h>
#import"DisplayMap.h"
#import"AddsObject.h"
#import"ApunKaBazarAppDelegate.h"
#import"AddsWebViewController.h"
@interface MapViewController()

- (void) resetTheView;
- (void) updateRatingGiven: (int) rating;

@end

@implementation MapViewController

@synthesize webView;

@synthesize headerView;
@synthesize placeTitle;
@synthesize placeName;
@synthesize placeAddress;
@synthesize placePhoneno;
@synthesize placeDistance;
@synthesize placeWebsite;
@synthesize placeEmail;

@synthesize placeImage;

@synthesize otherImage1;
@synthesize otherImage2;
@synthesize otherImage3;

@synthesize star1;
@synthesize star2;
@synthesize star3;
@synthesize star4;
@synthesize star5;
@synthesize activityIndicator;

@synthesize thisRestaurant;
@synthesize mapView;

@synthesize addsTimer;
@synthesize count;
@synthesize AddImageView;
@synthesize deScriptionLabel;
@synthesize Addbutton;




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[super viewDidLoad];
	
	self.navigationItem.title = thisRestaurant.resCategory;
	self.webView.delegate = self;
	self.webView.layer.cornerRadius = 5.0;
	[self createAnnotations];
	self.activityIndicator.hidesWhenStopped = YES;
	[self.activityIndicator startAnimating];
	//[self performSelector:@selector(loadMapView) withObject:nil afterDelay:0.1];
	
	//appDelegate=[UIApplication sharedApplication]delegate];
	appDelegate=(ApunKaBazarAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	self.placeName.text = thisRestaurant.resname;
	self.placeTitle.text = thisRestaurant.resname;
	
	
	// Start loading image for imgView
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
	self.placeDistance.text = [NSString stringWithFormat:@"%0.2f mi",dis];
	
	if([thisRestaurant.address length]>1)
	{
	
	NSArray *array=[thisRestaurant.address componentsSeparatedByString:@","];
	NSLog(@"array is %@",array);
	
	NSMutableString *string1=[[NSMutableString alloc]init];
	NSMutableString *string3=[[NSMutableString alloc]init];
	for(int i=0;i<[array count];i++)
	{  
		if(i<[array count]-2)
		{
			
			//if(i==1||i==2)
			//{
			
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
	//int lenght1=[string3 length];
	//string3=[string3 substringToIndex:lenght1-1];
	//int lengths=[string3 length];
	
	
	[string3 appendString:string1];
	int lenght=[string3 length];
	
	NSString *finalString3=[string3 substringToIndex:lenght-1];
	//[string3 appendString:string1];
	NSLog(@"String 3 is %@",finalString3);
	
	[string1 release];
	[string3 release];
	
	
	
	self.placeAddress.text =finalString3;
		
	}
	else {
		
		
		self.placeAddress.text =@"";
		
		
	}

	
	NSMutableString *phoneString=[[NSMutableString alloc]initWithString:@"Ph: "];
	[phoneString appendString:thisRestaurant.phoneno];
	self.placePhoneno.text = phoneString;
	self.placeWebsite.text = thisRestaurant.WebSiteUrl;
	self.placeEmail.text = thisRestaurant.Email;
	
	//[self createAnnotations];
	[self resetTheView];
	
		
	
	
	// Uncomment when using MKMapView
	/*
	regionLatitude = 37.0625;
	regionLongitude = -95.677068;
	[self setRegion];
	 */
	[self addImagesMethod];
	
}

- (void) resetTheView
{
	CGRect viewFrame = self.view.frame;
	viewFrame.origin.y = self.navigationController.navigationBar.frame.size.height;
	viewFrame.size.height = 460 - self.navigationController.navigationBar.frame.size.height;
	self.view.frame = viewFrame;
}

- (void) updateRatingGiven: (int) rating
{
	for (int i = 1; i <= rating; i++) 
	{
		UIImageView *star = (UIImageView *)[self.view viewWithTag:i];
		[star setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
	}
}



-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		static NSString *defaultPinID = @"com.invasivecode.pin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
										  initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
		
		NSLog(@"i am not here");
		pinView.pinColor = MKPinAnnotationColorRed; 
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
	} 
	else {
		NSLog(@"i am here");
		[mapView.userLocation setTitle:@"I am here"];
	}
	return pinView;
}








-(void)createAnnotations
{
	[mapView setMapType:MKMapTypeStandard];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
	region.center.latitude = [thisRestaurant.latitude floatValue];
	NSLog(@"lattitude is %@",thisRestaurant.latitude);
	region.center.longitude = [thisRestaurant.longitude floatValue];
		NSLog(@"long  is %@",thisRestaurant.longitude);
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapView setRegion:region animated:YES]; 
	[mapView setDelegate:self];
	DisplayMap *ann = [[DisplayMap alloc] init]; 
	ann.title =thisRestaurant.resname;
	//ann.subtitle = @"Mahatma Gandhi Road"; 
	ann.coordinate = region.center; 
	[mapView addAnnotation:ann];
}
	
	
	
	








/*
- (void) loadMapView
{
	
	
	NSString *mapUrl = [NSString stringWithFormat:@"http://maps.google.com?q=%@",thisRestaurant.address];
	NSString *tempString = [mapUrl stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];;
	NSString *encodedString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
	NSLog(@"encodedString: %@",encodedString);
	NSURL *url = [NSURL URLWithString:encodedString];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:urlRequest];
	
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
	[self.activityIndicator stopAnimating];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error!" message:@"Experiencing connection problems" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
	[alert show];
	[alert release];
	[self.activityIndicator stopAnimating];
}
 */

- (void) requestFinished:(ASIHTTPRequest *)request
{
	NSData *imgData = [request responseData];
	UIImage *image = [UIImage imageWithData:imgData];
	
	if(image)
	{
	CALayer *imgLayer = [CALayer layer];
	imgLayer.frame = CGRectMake(0, 0, self.placeImage.frame.size.width, self.placeImage.frame.size.height);
	imgLayer.contents = (id)image.CGImage;
	[self.placeImage.layer addSublayer:imgLayer];
	self.placeImage.layer.cornerRadius = 5.0;
	}
	else {
		self.placeImage.image=[UIImage imageNamed:@"no-image.png"];
	}

	[self.activityIndicator stopAnimating];
	imgRequest.delegate = nil;
	imgRequest = nil;
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
	imgRequest.delegate = nil;
	imgRequest = nil;
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


-(void)viewWillAppear:(BOOL)animated
{
	self.addsTimer=[NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(addImagesMethod) userInfo:nil repeats:YES];
	
}

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


-(void)viewDidDisappear:(BOOL)animated
{
	count=0;
	[self.addsTimer invalidate];
}









- (void)dealloc 
{
	if (imgRequest) 
	{
		imgRequest.delegate = nil;
		[imgRequest cancel];
		imgRequest = nil;
	}
	
	
	
	[thisRestaurant release];
	
	[placeTitle release];
	placeTitle = nil;
	[headerView release];
	headerView = nil;
	
	[activityIndicator release];
	activityIndicator = nil;
		
	[placeName release];
	placeName = nil;
	[placeAddress release];
	placeAddress = nil;
	[placePhoneno release];
	placePhoneno = nil;
	[placeDistance release];
	placeDistance = nil;
	
	[placeImage release];
	placeImage = nil;
	
	[otherImage1 release];
	otherImage1 = nil;
	[otherImage2 release];
	otherImage2 = nil;
	[otherImage3 release];
	otherImage3 = nil;
	
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
	
	[mapView release];
	mapView = nil;
	
	[placeEmail release];
	placeEmail = nil;
	[placeWebsite release];
	placeWebsite = nil;
 
	[super dealloc];
}


@end

