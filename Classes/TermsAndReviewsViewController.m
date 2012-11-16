//
//  TermsAndReviewsViewController.m
//  ApunKaBazar
//
//  Created by stellentmac1 on 7/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TermsAndReviewsViewController.h"
#import"HomeViewController.h"


@implementation TermsAndReviewsViewController
@synthesize checkButton;
@synthesize termtextView;
@synthesize ter1label,ter11label,ter2label,ter21label,ter3label,te31label,scrollview;
@synthesize GuestscrollView;
@synthesize RegistredScrollView;


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
- (void)viewDidLoad {
    [super viewDidLoad];
	appDelegate=(ApunKaBazarAppDelegate *)[[UIApplication sharedApplication]delegate];
	//[scrollview setContentSize:CGSizeMake(320,550)];
	
	
	if([appDelegate.TermsFromPage isEqualToString:@"LoginAsGuest"])
	{
        /*
		[self.RegistredScrollView removeFromSuperview];
		[self.GuestscrollView setFrame:CGRectMake(0,63,320,350)];
		[self.view addSubview:self.GuestscrollView];
		[self.GuestscrollView setContentSize:CGSizeMake(320,500)];
        */
        
        [self.GuestscrollView removeFromSuperview];
		[self.RegistredScrollView setFrame:CGRectMake(0,63,320,350)];
		[self.view addSubview:self.RegistredScrollView];
		[self.RegistredScrollView setContentSize:CGSizeMake(320,750)];

		
	}
	
	if([appDelegate.TermsFromPage isEqualToString:@"SignUp"])
	{
		
		[self.GuestscrollView removeFromSuperview];
		[self.RegistredScrollView setFrame:CGRectMake(0,63,320,350)];
		[self.view addSubview:self.RegistredScrollView];
		[self.RegistredScrollView setContentSize:CGSizeMake(320,750)];
		
	}
	
	
	
	
	
	/*
	
	NSString *string1=[@"1.Your relationship with ApunKaBazaar	 
					Your agreement with ApunKaBazaar will also include the terms of any Legal Notices applicable to the Services,in addition to the Universal Terms
	It is important that you take the time to read them carefully. Collectively, this legal agreement is referred to 
	below as the "Terms"
	 
	 
	@""2. Access to Services
	       In order to access certain Services, you may be required to provide information about yourself (such as 
	identification or contact details) as part of the registration process for the Service.
	    You agree not to access (or attempt to access) any of the Services by any means other than through the interface that is provided by ApunKaBazaar, unless you have been specifically allowed to do so in a separate agreement.
	      Unless you have been specifically permitted to do so in a separate agreement with ApunKaBazaar, you agree that you will not reproduce, duplicate, copy, sell, trade or resell the Services for any purpose.
	
	3. Your passwords and account security
	      You agree and understand that you are responsible for maintaining the confidentiality of passwords associated with any account you use to access the Services.
	     Accordingly, you agree that you will be solely responsible for all activities that occur under your account."
	
	
	self.termtextView.text=strings;
	 */
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


-(IBAction)backbuttonpressed:(id)sender
{
	
	[self.view removeFromSuperview];

	//[self dismissModalViewControllerAnimated:YES];
}


/*
-(IBAction)CheckBoxButtonPressed:(id)sender
{
	
	NSLog(@"Check Box Button Pressed");
	if(appDelegate.checkBoxPressed==0)
	{
		NSLog(@"Checkbox Value 0");
		[checkButton setImage:[UIImage imageNamed:@"Checkbox_checked.png"] forState:UIControlStateNormal];
		
		
		if([appDelegate.TermsFromPage isEqualToString:@"LoginAsGuest"])
		{
		
			[self performSelector:@selector(loginasguest) withObject:nil afterDelay:1.0];
		
		}
		if([appDelegate.TermsFromPage isEqualToString:@"SignUp"])
		{
			NSLog(@"login as signup");
			[self.view removeFromSuperview];
			appDelegate.checkBoxPressed=1;
		}
		
		
		
		//return;
	}
	
	if(appDelegate.checkBoxPressed==1)
	{
		
		[self performSelector:@selector(signup) withObject:nil afterDelay:1.0];
		
	}
	
	
}
 */

-(void)signup
{
	NSLog(@"Checkbox Value 1");
	[checkButton setImage:[UIImage imageNamed:@"Checkbox.png"] forState:UIControlStateNormal];
	appDelegate.checkBoxPressed=1;
	
	
}




-(void)loginasguest
{
	
	
	NSLog(@"login as guest");
	
	
	HomeViewController *hViewController=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
	appDelegate.homeViewController=hViewController;
	[hViewController release];
	
	UINavigationController *nController=[[UINavigationController alloc] initWithRootViewController:appDelegate.homeViewController];
	appDelegate.navController=nController;
	[nController release];
	appDelegate.username=@"";
	[appDelegate.window addSubview:appDelegate.navController.view];
	[self.view removeFromSuperview];
	
	//appDelegate.checkBoxPressed=1;
	
	
	
}




-(IBAction)IagreeButtonPressed:(id)sender
{
	
	if([appDelegate.TermsFromPage isEqualToString:@"LoginAsGuest"])
	{
		NSLog(@"login as guest");
		
		
		HomeViewController *hViewController=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
		appDelegate.homeViewController=hViewController;
		[hViewController release];
		
		UINavigationController *nController=[[UINavigationController alloc] initWithRootViewController:appDelegate.homeViewController];
		appDelegate.navController=nController;
		[nController release];
		appDelegate.username=@"";
		[appDelegate.window addSubview:appDelegate.navController.view];
		[self.view removeFromSuperview];
		
		//appDelegate.checkBoxPressed=1;
		
	}
	if([appDelegate.TermsFromPage isEqualToString:@"SignUp"])
	{
		NSLog(@"login as signup");
		[self.view removeFromSuperview];
		appDelegate.checkBoxPressed=1;
	}
	
	
	
}



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


- (void)dealloc {
	
	[GuestscrollView release];
    [RegistredScrollView release];
	[termtextView release];
	[checkButton release];
    [super dealloc];
}


@end
