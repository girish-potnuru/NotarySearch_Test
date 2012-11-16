//
//  LoginViewController.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import "ForgotPasswordViewController.h"

#import "ApunKaBazarAppDelegate.h"
#import"TermsAndReviewsViewController.h"
#import "HomeViewController.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoginViewController
@synthesize signUpViewController;
@synthesize forgotpasswordViewController;
@synthesize userId;
@synthesize passWord;
@synthesize currTextField;
@synthesize navibr;
@synthesize termsReviewViewController;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	
	appDelegate=(ApunKaBazarAppDelegate *)[[UIApplication sharedApplication] delegate];
	
    [super viewDidLoad];
	
	//self.navibr.layer.contents = (id)[UIImage imageNamed:@"navbar.png"].CGImage;
	
	CGRect frame1 = CGRectMake(-5, 0,320, 48);
	
	UIView *textview=[[[UIView alloc] initWithFrame:frame1] autorelease];
	
	UIImageView *image= [[[UIImageView alloc] initWithFrame:frame1] autorelease];
	image.image = [UIImage imageNamed:@"navbar.png"];
	
	UILabel *label = [[[UILabel alloc] initWithFrame:frame1] autorelease];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:20.0];
	label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
	label.textAlignment = UITextAlignmentCenter;
	label.textColor = [UIColor blueColor];
	
	NSString *string=@"Login";
	label.text =string;
	[textview addSubview:image];
	[textview addSubview:label];
		
	self.navibr.topItem.titleView =textview;
	
	
	
	//self.navigationController.navigationItem.layer.contents=[UIImage imageNamed:@"navbar.png"].CGImage;
	
	//self.navigationController.navigationBar.tintColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"navbar.png"]]; 
	CGRect frame=self.view.frame;
	frame.origin.y=20;
	self.view.frame=frame;
	self.passWord.secureTextEntry=YES;
	
}
-(void)viewWillAppear:(BOOL)animated
{
	appDelegate = (ApunKaBazarAppDelegate *)[[UIApplication sharedApplication] delegate];
}



- (IBAction) submitClicked:(id) sender
{
	[passWord resignFirstResponder];
	[userId resignFirstResponder];
	
	[self setViewMovedUp:NO];
	
	NSString *urlString1=[NSString stringWithFormat:@"%@login.php",URLprefix];
	NSLog(@"url Sting is %@",urlString1);
	NSURL *url=[[NSURL alloc] initWithString:urlString1];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[url release];
	//userId.text=@"naveen";
	//passWord.text=@"54321";
	NSLog(@"userId:%@",userId.text);
	passWord.secureTextEntry=YES;
	NSLog(@"passWord:%@",passWord.text);
	[request setPostValue:userId.text forKey:@"username"];
	
	[request setPostValue:passWord.text forKey:@"password"];
	//NSLog(@"Password:%@", loginObject.pWord);
	
	[request setDelegate:self];
	[request startSynchronous];
	
	NSError *error=[request error];
	if(!error)
	{
		NSString *response=[request responseString];
		NSLog(@"response is %@",response);
		NSData *responseData=[request  responseData];
		NSString *responseString=[[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
		
		NSDictionary *results=[responseString JSONValue];
		NSLog(@"results dictionary is %@",results);
		[responseString release];
		
		if([[results objectForKey:@"message"] isEqualToString:@"provide values"])
		{
			UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"ApunkaBazaar" message:@"Please Enter UserId and PassWord" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];	
		}
		else if([[results objectForKey:@"message"] isEqualToString:@"login success"])
		{
			//UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"" message:@"Login successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//			[alert show];
//			[alert release];
			//HomeViewController *homeView = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
//			[self.navigationController pushViewController:homeView animated:YES];
//			[homeView release];
			appDelegate.username=userId.text;
			HomeViewController *hViewController=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
			appDelegate.homeViewController=hViewController;
			[hViewController release];
			
			UINavigationController *nController=[[UINavigationController alloc] initWithRootViewController:appDelegate.homeViewController];
			appDelegate.navController=nController;
			[nController release];
			
			[appDelegate.window addSubview:appDelegate.navController.view];
			
			[self.view removeFromSuperview];
		}
		else if([[results objectForKey:@"message"] isEqualToString:@"login failed"]) 
		{
			[passWord resignFirstResponder];
			[userId resignFirstResponder];
			[self setViewMovedUp:NO];
			
			passWord.text=@"";
			//userId.text=@"";
			
			
			UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"ApunkaBazaar" message:@"Please Enter Correct UserId and Password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
			
			
			
		
		}
	}
		
		//NSString *statusMessage = [request responseStatusMessage];
	    //NSLog(@"Request Ack:%@",statusMessage);
}
	
			
-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

	if ([string isEqualToString:@"\n"]) {
		[textField resignFirstResponder];
		[self setViewMovedUp:NO];
		return NO;
		
	}
	return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)sender
{ 
	//	 myScrollView.contentSize=CGSizeMake(300.0f,600.0f);
	if (currTextField) 
	{
		[currTextField release];
	}
	currTextField = [sender retain];
	
	
	//move the main view, so that the keyboard does not hide it.
	if(sender.tag==1||sender.tag==2){
		[self setViewMovedUp:YES];
	}	
		if (self.view.frame.origin.y + currTextField.frame.origin.y >= 150) 
	{
		[self setViewMovedUp:YES]; 
	}
}


-(void)setViewMovedUp:(BOOL)movedUp
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3]; // if you want to slide up the view
	
	CGRect rect = self.view.frame;
	
	if (movedUp)
	{
		// 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
		// 2. increase the size of the view so that the area behind the keyboard is covered up.
		rect.origin.y = -170;//kMin - currTextField.frame.origin.y ;
		
		//[self.myScrollView setScrollsToTop:YES];
		
	}
	else
	{
		// revert back to the normal state.
		rect.origin.y = 20;
		//[self.myScrollView setScrollsToTop:NO];
	}
	self.view.frame = rect;
	[UIView commitAnimations];
}


/*
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text 
{ 
	if([text isEqualToString:@"\n"]) 
	[textView resignFirstResponder]; 
	return YES;

}
 */


- (IBAction) registerClicked:(id) sender
{
	[passWord resignFirstResponder];
	[userId resignFirstResponder];
	
	[self setViewMovedUp:NO];
	
	NSLog(@"RegiteredButton Clicked");
	SignUpViewController *signViewController=[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
	self.signUpViewController=signViewController;

	[self presentModalViewController:self.signUpViewController animated:YES];
	
	[signViewController release];
	 
	
}


- (IBAction) forgotPasswordClicked: (id) sender
{
	[passWord resignFirstResponder];
	[userId resignFirstResponder];
	
	[self setViewMovedUp:NO];
	NSLog(@"Forgotpassword btn. Clicked");
	ForgotPasswordViewController *fViewController=[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
	self.forgotpasswordViewController=fViewController;
	
	[self presentModalViewController:self.forgotpasswordViewController animated:YES];
	
	[fViewController release];
}

- (IBAction) loginAsGuestClicked: (id) sender
{
    [passWord resignFirstResponder];
	[userId resignFirstResponder];
	[self setViewMovedUp:NO];
	
	passWord.text=@"";
	userId.text=@"";

	appDelegate.TermsFromPage=[NSMutableString stringWithString:@"LoginAsGuest"];
	TermsAndReviewsViewController *termsandreview=[[TermsAndReviewsViewController alloc]initWithNibName:@"TermsAndReviewsViewController" bundle:nil];
	self.termsReviewViewController=termsandreview;
	[termsandreview release];
	//[self.termsReviewViewController setFrame:CGRectMake(0,20,320,460)];
	[appDelegate.window addSubview:self.termsReviewViewController.view];
	/*
	UINavigationController *nController=[[UINavigationController alloc] initWithRootViewController:self.termsReviewViewController];
	//[nController.navigationController.navigationBar setHidden:YES];
	[nController.navigationBar setHidden:YES];
	appDelegate.navController=nController;
	[nController release];
	[appDelegate.window addSubview:appDelegate.navController.view];
	[self.view removeFromSuperview];
	*/
	
	
	
	/*
	HomeViewController *hViewController=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
	appDelegate.homeViewController=hViewController;
	[hViewController release];
	
	UINavigationController *nController=[[UINavigationController alloc] initWithRootViewController:appDelegate.homeViewController];
	appDelegate.navController=nController;
	[nController release];
	appDelegate.username=@"";
	[appDelegate.window addSubview:appDelegate.navController.view];
	[self.view removeFromSuperview];
	*/
	 
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[forgotpasswordViewController release];
	[signUpViewController release];
    [super dealloc];
}


@end
