//
//  SignUpViewController.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SignUpViewController.h"
#import "RegisterCell.h"
#import "ASIFormDataRequest.h"
#import "LoginObject.h"
#import "ApunKaBazarAppDelegate.h"
#import "JSON.h"
#import "HomeViewController.h"
#import"TermsAndReviewsViewController.h"


@implementation SignUpViewController

@synthesize regCell;
@synthesize tableView;
@synthesize loginObject;
@synthesize checkButton;
@synthesize termsAndReviewViewController;
@synthesize spinner;

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
    [super viewDidLoad];
	checkBoxPressed=0;
	self.tableView.backgroundColor=[UIColor clearColor];
	loginObject	= [[LoginObject alloc] init];
	currentTextField.delegate=self;
	appDelegate = (ApunKaBazarAppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void)viewWillAppear:(BOOL)animated
{
	
	[tableView reloadData];
	
}



- (IBAction) submitClicked: (id) sender
{
	
	NSLog(@"appdelegate checkbox value is %d",appDelegate.checkBoxPressed);
	
	[currentTextField resignFirstResponder];

	NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	
	if([loginObject.uName isEqualToString:@""]||[loginObject.pWord isEqualToString:@""]||[loginObject.eMail isEqualToString:@""])//||(appDelegate.checkBoxPressed==0))
	{
		
		UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Register form" message:@"Please enter all the fileds" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		
		[alertView show];
		[alertView release];
		
		NSLog(@"no values");
		return;
		
		
	}
		
		//Valid email address
		else if([emailTest evaluateWithObject:loginObject.eMail] ==NO) 
		{
		
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"E-Mail field not in proper format"  message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
			[alert show];
			[alert release];
			
			//return;
		}
	
	else if((appDelegate.checkBoxPressed==0))
	{
		
		UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Register form" message:@"Accept Terms And Conditions " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		
		[alertView show];
		[alertView release];
		
		
	}
	else 
	{
		[self.spinner startAnimating];
		[self performSelector:@selector(SubmitDetails) withObject:nil afterDelay:0.2];
		
	}

			 
	
	
	
}

-(void)SubmitDetails
{
	
	NSString *urlString1=[NSString stringWithFormat:@"%@signup.php",URLprefix];
	NSURL *url=[[[NSURL alloc] initWithString:urlString1] autorelease];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:loginObject.uName forKey:@"username"];
	NSLog(@"Username:%@", loginObject.uName);
	[request setPostValue:loginObject.pWord forKey:@"password"];
	NSLog(@"Password:%@", loginObject.pWord);
	[request setPostValue:loginObject.eMail forKey:@"email"];
	NSLog(@"email:%@", loginObject.eMail);
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
		
		if([[results objectForKey:@"message"] isEqualToString:@"required user fields"])
		{
			[self.spinner stopAnimating];
			NSLog(@"Please Provide all the fields");	
			UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"ApunKaBazaar" message:@"Please enter all values." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
			
		}
		else if([[results objectForKey:@"message"] isEqualToString:@"signup successfully completed"])
		{
			appDelegate.checkBoxPressed=0;
			appDelegate.username=loginObject.uName;
			
			//go to home screen
			HomeViewController *hViewController=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
			appDelegate.homeViewController=hViewController;
			[hViewController release];
			
			UINavigationController *nController=[[UINavigationController alloc] initWithRootViewController:appDelegate.homeViewController];
			appDelegate.navController=nController;
			[nController release];
			
			[self.spinner stopAnimating];
			[appDelegate.window addSubview:appDelegate.navController.view];
			
			
			//[self.view removeFromSuperview];
			[self dismissModalViewControllerAnimated:NO];
		}
		else {
						[self.spinner stopAnimating];
			UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"User Exist, please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[alert release];
		}
		
		
	
	}	
	
	
	
	
	
}




- (IBAction) backClicked: (id) sender
{

	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)TermsAndConditionsButton:(id)sender
{
	
	/*
	TermsAndReviewsViewController *trviewcontroller=[[TermsAndReviewsViewController alloc]initWithNibName:@"TermsAndReviewsViewController" bundle:nil];
	
	self.termsAndReviewViewController=trviewcontroller;
	[trviewcontroller release];
	//[self presentModalViewController:self.termsAndReviewViewController animated:YES];	
	*/
	[currentTextField resignFirstResponder];
	
	appDelegate.TermsFromPage=[NSMutableString stringWithString:@"SignUp"];
	TermsAndReviewsViewController *trviewcontroller=[[TermsAndReviewsViewController alloc]initWithNibName:@"TermsAndReviewsViewController" bundle:nil];
    self.termsAndReviewViewController=trviewcontroller;
	[trviewcontroller release];
	[appDelegate.window addSubview:self.termsAndReviewViewController.view];
	/*
	UINavigationController *nController=[[UINavigationController alloc] initWithRootViewController: self.termsAndReviewViewController];
	//[nController.navigationController.navigationBar setHidden:YES];
	[nController.navigationBar setHidden:YES];
	appDelegate.navController=nController;
	[nController release];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	//set hieght for the table section header
    return 0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
	//set hieght for the table section footer
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//set number of rows in the section for different sections 
	return 1;	
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//set the lable text for section 0, 2 and 4
	
	RegisterCell *mycell = (RegisterCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
	if (mycell==nil) 
	{
		[[NSBundle mainBundle] loadNibNamed:@"RegisterCell" owner:self options:nil];
		mycell=self.regCell;		
		
	}
	if(indexPath.section==0)
	{
		mycell.titleOfLabel.text=@"User Name:";
		[mycell setSelectionStyle:UITableViewCellSelectionStyleNone];
		[mycell.fieldOfText setBorderStyle:UITextBorderStyleNone];
		//NSDictionary appData = [[NSDictionary alloc]init];
		//mycell.fieldOfText.text=[self.appData objectForKey:@"FirstName"];
		mycell.fieldOfText.placeholder=@"User Name";
		mycell.fieldOfText.text=loginObject.uName;
		NSLog(@"cellfor rowatindex Username:%@",loginObject.uName);
		//appAppDelegate.fName=myobj.firstName;
		mycell.fieldOfText.tag=1;

		//mycell.fieldOfText.tag=indexPath.section+1;
		//mycell.nameOfLabel.tag=1;
	}
	else if(indexPath.section==1)
	{
		mycell.titleOfLabel.text=@"Password:";
		//mycell.fieldOfText.text=[self.userDeatilsDict objectForKey:@"LastName"];
		//mycell.fieldOfText.secureTextEntry=YES;
		//mycell.fieldOfText.placeholder=@"Last Name";
		[mycell setSelectionStyle:UITableViewCellSelectionStyleNone];
		[mycell.fieldOfText setBorderStyle:UITextBorderStyleNone];
		
		//for Pass word ***
		mycell.fieldOfText.secureTextEntry=YES;
		//
		
		
		mycell.fieldOfText.text=loginObject.pWord;
		NSLog(@"cellfor rowatindex password:%@",loginObject.pWord);
		//appAppDelegate.lName=myobj.lastName;
		
		//mycell.fieldOfText.tag=indexPath.section+1;
		mycell.fieldOfText.tag=2;
		//mycell.fieldOfText.tag=2;
	}
	else if(indexPath.section==2)
	{
		mycell.titleOfLabel.text=@"E-mail:";
		
		//mycell.fieldOfText.text=[self.userDeatilsDict objectForKey:@"Email"];
		mycell.fieldOfText.placeholder=@"Enter Valid E-mail";
		[mycell setSelectionStyle:UITableViewCellSelectionStyleNone];
		[mycell.fieldOfText setBorderStyle:UITextBorderStyleNone];
		mycell.fieldOfText.text=loginObject.eMail;
		
		NSLog(@"cellfor rowatindex email:%@",loginObject.eMail);
		
		//appAppDelegate.eMail=myobj.eMail;
		
		//mycell.fieldOfText.tag=indexPath.section+1;
		mycell.fieldOfText.tag=3;
		//mycell.fieldOfText.tag=3;
	}
	
	
	
	mycell.titleOfLabel.textColor=[UIColor blackColor];
	return mycell;
	
	
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
	currentTextField=textField;
}
-(void)textFieldDidEndEditing:(UITextField *)sender
{
	if (sender.tag==1) 
	{
		loginObject.uName=sender.text;
	}else if (sender.tag==2) {
		loginObject.pWord=sender.text;	
	}else if (sender.tag==3) {
		NSLog(@"sender.text is %@",sender.text);
		loginObject.eMail=sender.text;
	}
	
	 
	
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)sender
{
	return YES;
}

/*
- (void)textFieldDidEndEditing:(UITextField *)textField{
	[textField resignFirstResponder];
}
*/
/*
-(IBAction)CheckBoxButtonPressed:(id)sender
{
	NSLog(@"Check Box Button Pressed");
	if(checkBoxPressed==0)
	{
		NSLog(@"Checkbox Value 0");
		[checkButton setImage:[UIImage imageNamed:@"Checkbox_checked.png"] forState:UIControlStateNormal];
		checkBoxPressed=1;
		return;
	}

	if(checkBoxPressed==1)
	{
				NSLog(@"Checkbox Value 1");
		[checkButton setImage:[UIImage imageNamed:@"Checkbox.png"] forState:UIControlStateNormal];
		checkBoxPressed=0;
	}
	
	
}
*/
- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[spinner release];
	[checkButton release];
	[loginObject release];
    [super dealloc];
}


@end
