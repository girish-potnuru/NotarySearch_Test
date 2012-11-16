//
//  ApunKaBazarAppDelegate.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ApunKaBazarAppDelegate.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
#import "MyCLController.h";
#import"JSON.h"
#import"ASIHTTPRequest.h"
#import"AddsObject.h"

@implementation ApunKaBazarAppDelegate

@synthesize window;
@synthesize navController;
@synthesize homeViewController;
@synthesize loginViewController;
@synthesize checkBoxPressed;
@synthesize username;
@synthesize TermsFromPage;
@synthesize FoodQualityRating;
@synthesize AtmosphereRating;
@synthesize ValueRating;
@synthesize ServiceRating;
@synthesize comment;
@synthesize selectedCategory;
@synthesize CompleteRating;
@synthesize  IsWriteReviewPage;
@synthesize locationController;
@synthesize  currentLocation;
@synthesize addImagesArray;
@synthesize spinner;
@synthesize splashView;
@synthesize asiRequest;
@synthesize ImagesconvertingArray;
@synthesize count;
@synthesize addsTimer;
#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
    // Override point for customization after application launch.
    //HomeViewController *hViewController=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
//	self.homeViewController=hViewController;
//	[hViewController release];
//	
//	UINavigationController *nController=[[UINavigationController alloc] initWithRootViewController:self.homeViewController];
//	self.navController=nController;
//	[nController release];
//	
//	[self.window addSubview:self.navController.view];
	count=0;
	ImagesconvertingArray=[[NSMutableArray alloc]init];
	addImagesArray=[[NSMutableArray alloc]init];
	
	//[self createAdd];
	locationController = [[MyCLController alloc] init];
	locationController.delegate = self; 
	locationController.locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
	locationController.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer; // 1 Km
	
	///To set the current location from GPS
	[locationController.locationManager startUpdatingLocation];
	IsWriteReviewPage=NO;
	TermsFromPage=[[NSMutableString alloc]init];
	
	
	
	spinner=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	spinner.frame=CGRectMake(140, 400,25,25);
	[window addSubview:spinner];
	splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 480)];
	splashView.image = [UIImage imageNamed:@"splash_screen.png"];
	splashView.alpha=0.1;
	[window addSubview:splashView];
	[window bringSubviewToFront:splashView];
	[window bringSubviewToFront:spinner];
	[spinner startAnimating];
	[self createAdd];
	
	self.addsTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(createImages) userInfo:nil repeats:YES];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:2.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:window cache:YES];
	[UIView setAnimationDelegate:self]; 
	[UIView setAnimationDidStopSelector:@selector(finishAnimation)];
	splashView.alpha = 1.0;
	splashView.frame = CGRectMake(0, 0, 320, 480);
	//[self performSelector:@selector(removeSplash) withObject:nil afterDelay:1.5];
	[UIView commitAnimations];
			
    [self.window makeKeyAndVisible];
    
    return YES;
}


-(void)finishAnimation
{
	
	LoginViewController *lViewController=[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
	self.loginViewController=lViewController;
	//[self performSelector:@selector(createAdd) withObject:nil afterDelay:0.2];
	[self.window addSubview:self.loginViewController.view];
	[lViewController release];
	
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	
	/*
	NSLog(@"enter background");
	
	[self.addsTimer invalidate];
	[ImagesconvertingArray removeAllObjects];
	[addImagesArray removeAllObjects];
	
	*/
	
	
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	
	/*
	
	NSLog(@"enter foreground");
	[self createAdd];
	self.addsTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(createImages) userInfo:nil repeats:YES];
	
	*/
	
	
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
	 */
	
	NSLog(@"in application will terminate");
	
		
	
	
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)locationUpdate:(CLLocation *)location 
{	
	self.currentLocation = location.coordinate;
	
	NSLog(@"goto current location");
}
- (void)locationError:(NSError *)error 
{
	NSLog(@"error found at location updater");
//	[locationController.locationManager stopUpdatingLocation];	
}

/*

-(void)createAdd
{
	

	NSMutableArray *objectArray=[[NSMutableArray alloc]init];
	//NSString *urlString1=[NSString stringWithFormat:@"%@getads.php",URLprefix];
	NSString *urlString1=@"http://www.myappdemo.com/ApunKaBazaar/services/getads.php";
	NSLog(@"%@",urlString1);
	NSURL *url1=[[NSURL alloc] initWithString:urlString1];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url1];
	[request setDelegate:self];
	[request startSynchronous];
	[url1 release];
	NSError *error = [request error];
	if (!error)
	{
		NSString *response = [request responseString];
		NSLog(@"response:%@",response);
		NSData *responseData=[request responseData];
		NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
		NSMutableArray *array = [responseString JSONValue];
		
		
		for (int i=0;i<[array count];i++)
		{
			
			NSDictionary *dict=[array objectAtIndex:i];
			
			AddsObject *object=[[AddsObject alloc]init];
			
			object.imageUrl=[dict objectForKey:@"Image"];
			object.Description=[dict objectForKey:@"Description"];
			object.DescriptionURl=[dict objectForKey:@"Web Url"];
			
			
			
			
			//NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",object.imageUrl]]];
			//UIImage *images=[UIImage imageWithData:data];
			//object.addImage=images;
			
			[objectArray addObject:object];
			[object release];

		}
		
		
		//self.addImagesArray=objectArray;
		[self.ImagesconvertingArray addObjectsFromArray:objectArray];
		
		[objectArray release];
		
		
	}
	
	
	[self performSelector:@selector(createImages) withObject:nil afterDelay:0.2];
	
}

-(void)createImages
{
	//count;
	if(count<[self.ImagesconvertingArray count])
	{
	AddsObject *object =[self.ImagesconvertingArray objectAtIndex:count];
	[self createAddImages:object.imageUrl];
		
		count++;
	}
	if(count==[self.addImagesArray count])
	{
		//[addsTimer invalidate];
		count=0;
		
		if([self.ImagesconvertingArray count]>0)
		{
		[self.ImagesconvertingArray removeAllObjects];
		}
		 
		//
	}
		
	
}
 

//self.addImagesArray=objectArray;

-(void)createAddImages:(NSString *)urlString
//-(void)createAddImages:(AddsObject *)addobject
{
	//http://www.myappdemo.com/ApunKaBazaar/services/getMenu.php?catid=1
	//NSString *urlString1=[NSString stringWithFormat:@"%@getads.php",URLprefix];
	NSLog(@"%@",urlString);
	NSURL *url1=[[NSURL alloc] initWithString:urlString];
	asiRequest = [ASIFormDataRequest requestWithURL:url1];
	[asiRequest setDelegate:self];
	//[asiRequest setValue:@"1" forKey:@"tag"];
	[asiRequest setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",count] forKey:@"tag"]];
	[asiRequest startAsynchronous];
	
	[url1 release];
	
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
	NSString *str=[[request userInfo] objectForKey:@"tag"];
	
	//NSLog(@"priya:%@",str);
	asiRequest.delegate = nil;
	asiRequest = nil;
	NSMutableArray *objectArray=[[NSMutableArray alloc]init];
	NSString *response = [request responseString];
	NSLog(@"response:%@",response);
	NSData *responseData=[request responseData];
	AddsObject *object=[[AddsObject alloc]init];
	UIImage *images=[UIImage imageWithData:responseData];
	object.tagValue=[[request userInfo] objectForKey:@"tag"];
	object.addImage=images;
	
	NSLog(@"description array count is %d",[self.ImagesconvertingArray count]);
	/*
	if(([self.ImagesconvertingArray count]>0)&&(count<[self.ImagesconvertingArray count]))
	{
	AddsObject *object1 =[self.ImagesconvertingArray objectAtIndex:count];
	object.Description=object1.Description;
	NSLog(@"description is %@",object.Description);
	}
	 */
	
	//[self.addImagesArray addObject:object];
	//[self performSelector:@selector(createImages) withObject:nil afterDelay:0.2];
		
	
	//[object release];
		
	
//}
//*/


-(void)createAdd
{
	NSString *urlString1=[NSString stringWithFormat:@"%@getads.php",URLprefix];
	//NSString *urlString1=@"http://www.myappdemo.com/ApunKaBazaar/services/getads.php";
	
	NSMutableArray *objectArray=[[NSMutableArray alloc]init];
	//NSString *urlString1=[NSString stringWithFormat:@"%@getads.php",URLprefix];
	NSLog(@"%@",urlString1);
	NSURL *url1=[[NSURL alloc] initWithString:urlString1];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url1];
	[request setDelegate:self];
	[request startSynchronous];
	[url1 release];
	NSError *error = [request error];
	if (!error)
	{
		NSString *response = [request responseString];
		NSLog(@"response:%@",response);
		NSData *responseData=[request responseData];
		NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
		NSMutableArray *array = [responseString JSONValue];
		
		
		for (int i=0;i<[array count];i++)
		{
			
			NSDictionary *dict=[array objectAtIndex:i];
			
			AddsObject *object=[[AddsObject alloc]init];
			
			object.imageUrl=[dict objectForKey:@"Image"];
			object.Description=[dict objectForKey:@"Description"];
			object.DescriptionURl=[dict objectForKey:@"Web Url"];
										
			[objectArray addObject:object];
			[object release];
			
		}
		
		
		//self.addImagesArray=objectArray;
		self.ImagesconvertingArray=objectArray;
		[objectArray release];
		
		
	}
	
	
	
	
}

-(void)createImages
{
	//count;
	if(count<[self.ImagesconvertingArray count])
	{
		AddsObject *object =[self.ImagesconvertingArray objectAtIndex:count];
		[self createAddImages:object.imageUrl];
		count++;
	}
	if(count==[self.addImagesArray count])
	{
		//[addsTimer invalidate];
	}
	
	
}


//self.addImagesArray=objectArray;

-(void)createAddImages:(NSString *)urlString
{
	//http://www.myappdemo.com/ApunKaBazaar/services/getMenu.php?catid=1
	//NSString *urlString1=[NSString stringWithFormat:@"%@getads.php",URLprefix];
	NSLog(@"%@",urlString);
	NSURL *url1=[[NSURL alloc] initWithString:urlString];
	asiRequest = [ASIFormDataRequest requestWithURL:url1];
	[asiRequest setDelegate:self];
	[asiRequest setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d",count] forKey:@"tag"]];
	[asiRequest startAsynchronous];
	
	[url1 release];
	
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
	NSString *str=[[request userInfo] objectForKey:@"tag"];
	asiRequest.delegate = nil;
	asiRequest = nil;
	NSMutableArray *objectArray=[[NSMutableArray alloc]init];
	NSString *response = [request responseString];
	NSLog(@"response:%@",response);
	NSData *responseData=[request responseData];
	AddsObject *object=[[AddsObject alloc]init];
	UIImage *images=[UIImage imageWithData:responseData];
	object.addImage=images;
	object.tagValue=[[request userInfo] objectForKey:@"tag"];
	[self.addImagesArray addObject:object];
	[object release];
	
	
}



- (void) requestFailed:(ASIHTTPRequest *)request
{
	asiRequest.delegate = nil;
	asiRequest = nil;
	
	//[self.activityIndicator stopAnimating];
}



- (void)dealloc {
	
	//[asiRequest release];
	[ImagesconvertingArray release];
	[CompleteRating release];
	[addImagesArray release];
	[selectedCategory release];
	[username release];
	[TermsFromPage release];
	[loginViewController release];
	[homeViewController release];
	[navController release];
    [window release];
    [super dealloc];
}


@end
