//
//  WriteReviewViewController.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WriteReviewViewController.h"
#import "ASIFormDataRequest.h"
#import "Restaurant.h"
#import"WriteReviewViewCell.h"
#import"WriteReviewCommentCell.h"
#import"ApunKaBazarAppDelegate.h"
#import"JSON.h"

@implementation WriteReviewViewController
@synthesize WriteReviewTableView;
@synthesize ReviewArray;
@synthesize reviewCommentCell,writereviewcell;
@synthesize currTextField;
@synthesize writeReviewDictionary;
@synthesize writereviewobject;
@synthesize FoodQualityRatingArray;
@synthesize AtmosphereRatingArray;
@synthesize valueRatingArray;
@synthesize ServiceRatingArray;
@synthesize sampleTextview;
@synthesize thisRestaurant;


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
	NSLog(@"WriteReviewViewController");
	[self.WriteReviewTableView setFrame:CGRectMake(0, 70, 320,460)];
	pickerMoved==0;
	self.WriteReviewTableView.backgroundColor=[UIColor clearColor];
	appDelegate=(ApunKaBazarAppDelegate *)[[UIApplication sharedApplication]delegate];
	writereviewobject=[[WriteReviewObject alloc]init];
	writereviewobject.Name=appDelegate.username;
	writeReviewDictionary=[[NSMutableDictionary alloc]init];
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
	self.navigationItem.rightBarButtonItem = saveButton;
	[saveButton release];
	
	FoodQualityRatingArray=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",nil];
	AtmosphereRatingArray=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",nil];
	valueRatingArray=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",nil];
	ServiceRatingArray=[[NSMutableArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",nil];
}


- (IBAction) save: (id) sender
{
	NSLog(@"Name is %@",writereviewobject.Name);
	NSLog(@"Title is %@",writereviewobject.TitleOfReview);
	NSLog(@"Completerating is %@",appDelegate.CompleteRating);
	NSLog(@"Your Review is %@",writereviewobject.comment);
	
	
	if(([writereviewobject.Name isEqualToString:@""]||[writereviewobject.TitleOfReview isEqualToString:@""]||[writereviewobject.comment isEqualToString:@""]||[appDelegate.CompleteRating isEqualToString:@""])||
	   ([writereviewobject.Name isKindOfClass:[NSNull class]])||([writereviewobject.TitleOfReview isKindOfClass:[NSNull class]])||([writereviewobject.comment isKindOfClass:[NSNull class]])||([appDelegate.CompleteRating isKindOfClass:[NSNull class]])
		||(writereviewobject.Name==nil)||(writereviewobject.TitleOfReview==nil)||(writereviewobject.comment==nil)||(appDelegate.CompleteRating==nil))
	{
		UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Provide All Fields" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	else
	{
		NSLog(@"Button pressed");
		NSString *urlString = [NSString stringWithFormat:@"%@addreview.php",URLprefix];
		reviewRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
		[reviewRequest setPostValue:thisRestaurant.resid forKey:@"restaurantid"];
		[reviewRequest setPostValue:[writereviewobject valueForKey:@"Name"] forKey:@"reviewname"];
		[reviewRequest setPostValue:appDelegate.CompleteRating forKey:@"ratevalue"];
     	[reviewRequest setPostValue:[writereviewobject valueForKey:@"TitleOfReview"] forKey:@"reviewtitle"];
		[reviewRequest setPostValue:writereviewobject.comment forKey:@"reviewdesc"];
		[reviewRequest startSynchronous];
				
		NSError *error = [reviewRequest error];
		
		if (!error) 
		{
			NSString *response = [reviewRequest responseString];
			NSLog(@"Response:%@",response);
			
			NSData *responseData=[reviewRequest responseData];
			
			NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
			NSDictionary *results = [responseString JSONValue];
			
			
			if ([[results objectForKey:@"message"] isEqualToString:@"successfully inserted"])
			{	
				UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Thanks For your valuable Response" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
				[alert setTag:1];
				[alert release];
			}
			
			if ([[results objectForKey:@"message"] isEqualToString:@"login success"])
			{	
				
			}
			
			
			//[responseString release];
			
		}
	}
	
	
	
}



- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1)
    {
		writereviewobject.Name=@"";
		writereviewobject.TitleOfReview=@"";
		appDelegate.CompleteRating=@"";
		writereviewobject.comment=@"";
		
		[self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
	
	
	appDelegate.IsWriteReviewPage=YES;
	
	
	/*
	writereviewobject.Name=@"";
	writereviewobject.TitleOfReview=@"";
	appDelegate.CompleteRating=@"";
	writereviewobject.comment=@"";
	*/
	
}


//////////////////////////////tableView Delegete Methods and picker methods/////////////////////////////////////////////////////////
//////////////////////////////-table view start delegate methods---------------------///////////////////////


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 4;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	//set number of rows in the section for different sections 
	return 1;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	//set the text for the cells for section 1 and 3
	if (indexPath.section == 3)
	{
		WriteReviewCommentCell *Commentcell = (WriteReviewCommentCell  *)[tableView dequeueReusableCellWithIdentifier:@"commentcell"];
		if (Commentcell==nil) 
		{
			[[NSBundle mainBundle] loadNibNamed:@"WriteReviewCommentCell" owner:self options:nil];
			Commentcell=reviewCommentCell;		
		}

		Commentcell.backgroundColor=[UIColor clearColor];
		Commentcell.commentTextView.tag=3;
		self.sampleTextview=Commentcell.commentTextView;
		Commentcell.commentTextView.text=writereviewobject.comment;
		NSLog(@"write object comment is %@",writereviewobject.comment);
		Commentcell.backgroundColor=[UIColor whiteColor];
		[Commentcell setSelectionStyle:UITableViewCellSelectionStyleNone];
		
		Commentcell.indexPath = indexPath;
		
		return Commentcell;
		
		
	}
	//set the lable text for section 0, 2 and 4
	else 
	{
		WriteReviewViewCell *mycell = (WriteReviewViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell1"];
		if (mycell==nil) 
		{
			[[NSBundle mainBundle] loadNibNamed:@"WriteReviewViewCell" owner:self options:nil];
			mycell=writereviewcell;		
			[mycell setSelectionStyle:UITableViewCellSelectionStyleNone];
			
		}
		if(indexPath.section==0)
		{
			if (indexPath.row==0)
			{
				mycell.MyfirstLabel.text=@"Name:";
				//mycell.MyTextField.frame=CGRectMake(95,3,200,31);
				mycell.MyTextField.placeholder=@"Name";
				mycell.MyTextField.text=writereviewobject.Name;
				[mycell setSelectionStyle:UITableViewCellSelectionStyleNone];
				mycell.MyTextField.tag=0;
			}
		}
		if(indexPath.section==1)
		{
			mycell.MyfirstLabel.text=@"Rating";
			//mycell.MyTextField.frame=CGRectMake(95,3,200,31);
			mycell.MyTextField.text=appDelegate.CompleteRating;
			mycell.MyTextField.userInteractionEnabled=NO;
			[mycell setSelectionStyle:UITableViewCellSelectionStyleNone];
			mycell.MyTextField.tag=1;
			[mycell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
		}
		if(indexPath.section==2)
		{
			mycell.MyfirstLabel.hidden=YES;
			CGRect labelFrame = mycell.MyTextField.frame;
			labelFrame.origin.x = 10;
			labelFrame.size.width = 280;
			mycell.MyTextField.frame = labelFrame;
			mycell.MyTextField.text=writereviewobject.TitleOfReview;
			[mycell setSelectionStyle:UITableViewCellSelectionStyleNone];
			mycell.MyTextField.tag=2;
		}
		
		mycell.indexPath = indexPath;
		
		mycell.MyfirstLabel.textColor=[UIColor blueColor];
		return mycell;
		
	}	
	
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section==3)
	{
		return 100;
	}
    else 
	{
		return 35;
	}
	
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if((section==0)||(section==1))
	{
		return 5;
	}

	else
	{
		return 35;
	}

    
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    	
	switch (section)
	{
	  
		case 0:
		{
			UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
			tempView.backgroundColor=[UIColor clearColor];
			
			UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
			tempLabel.backgroundColor=[UIColor clearColor]; 
			tempLabel.shadowColor = [UIColor blackColor];
			tempLabel.shadowOffset = CGSizeMake(0,2);
			tempLabel.textColor = [UIColor whiteColor]; //here u can change the text color of header
			tempLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
			tempLabel.font = [UIFont boldSystemFontOfSize:15.0];
			//tempLabel.text=@"Name";
			
			[tempView addSubview:tempLabel];
			
			[tempLabel release];
			return tempView;
		}
			break;
		case 1:
		{
			UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
			tempView.backgroundColor=[UIColor clearColor];
			
			UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
			tempLabel.backgroundColor=[UIColor clearColor]; 
			tempLabel.shadowColor = [UIColor blackColor];
			tempLabel.shadowOffset = CGSizeMake(0,2);
			tempLabel.textColor = [UIColor whiteColor]; //here u can change the text color of header
			tempLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			tempLabel.font = [UIFont boldSystemFontOfSize:17.0];
			//tempLabel.text=@"Food Quality";
			
			[tempView addSubview:tempLabel];
			
			[tempLabel release];
			return tempView;
		}
			break;
			
			
			
			
			
		case 6:
		{
			UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
			tempView.backgroundColor=[UIColor clearColor];
			
			UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
			tempLabel.backgroundColor=[UIColor clearColor]; 
			tempLabel.shadowColor = [UIColor blackColor];
			tempLabel.shadowOffset = CGSizeMake(0,2);
			tempLabel.textColor = [UIColor whiteColor]; //here u can change the text color of header
			tempLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			tempLabel.font = [UIFont boldSystemFontOfSize:17.0];
			//tempLabel.text=@"Atmosphere";
			
			[tempView addSubview:tempLabel];
			
			[tempLabel release];
			return tempView;
		}
			break;
			
			
		case 2:
		{
			UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
			tempView.backgroundColor=[UIColor clearColor];
			
			UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
			tempLabel.backgroundColor=[UIColor clearColor]; 
			tempLabel.shadowColor = [UIColor blackColor];
			//tempLabel.shadowOffset = CGSizeMake(0,2);
			tempLabel.textColor = [UIColor blueColor]; //here u can change the text color of header
			tempLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];	
			//tempLabel.font = [UIFont boldSystemFontOfSize:17.0];
			tempLabel.text=@"Title Of Review";
			
			[tempView addSubview:tempLabel];
			
			[tempLabel release];
			return tempView;
		}
			break;
			
		case 3:
		{
			UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,200,300,244)];
			tempView.backgroundColor=[UIColor clearColor];
			
			UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,300,44)];
			tempLabel.backgroundColor=[UIColor clearColor]; 
			tempLabel.shadowColor = [UIColor blackColor];
			//tempLabel.shadowOffset = CGSizeMake(0,2);
			tempLabel.textColor = [UIColor blueColor]; //here u can change the text color of header
			tempLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
			//tempLabel.font = [UIFont boldSystemFontOfSize:17.0];
			
			tempLabel.text=@"Your Review";
			[tempView addSubview:tempLabel];
			[tempLabel release];
			return tempView;
		}
			
			
					
			
	
	}
		 return [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
}







-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(indexPath.section==1)
	{
		pickerSelected=1;
				
		UIActionSheet *asheet = [[UIActionSheet alloc] initWithTitle:@"Rating" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Select", nil];
		
		UIPickerView *statePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
		statePicker.delegate=self;
		statePicker.showsSelectionIndicator = YES;
		[asheet addSubview:statePicker];
		[asheet showInView:[self.view superview]]; //note: in most cases this would be just self.view, but because I was doing this in a tabBar Application, I use the superview.
		[asheet setBounds:CGRectMake(0,0,320, 700)];
		[asheet setFrame:CGRectMake(0, 117, 320, 383)];
		NSArray *subviews = [asheet subviews];
		[asheet setTag:1];
		[[subviews objectAtIndex:1] setFrame:CGRectMake(20, 266, 280, 46)]; 
		[[subviews objectAtIndex:2] setFrame:CGRectMake(20, 317, 280, 46)];
		[statePicker release];
		[asheet release];
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==0) 
	{
		if(pickerMoved==0)
		{
			//NSLog(@"appDelegate.selectedCountry %@",appdelegate.selectedCountry);
			if(pickerSelected==1)
				appDelegate.CompleteRating=[NSString stringWithFormat:@"%@", [self.FoodQualityRatingArray objectAtIndex:0]];
			else if(pickerSelected==2)
				appDelegate.AtmosphereRating=[NSString stringWithFormat:@"%@", [self.AtmosphereRatingArray objectAtIndex:0]];
			else if(pickerSelected==3)
				appDelegate.ValueRating=[NSString stringWithFormat:@"%@", [self.valueRatingArray objectAtIndex:0]];
			else if(pickerSelected==4)
				appDelegate.ServiceRating=[NSString stringWithFormat:@"%@", [self.ServiceRatingArray objectAtIndex:0]];
		}
		pickerMoved=0;
		
		[self.WriteReviewTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
		[self.WriteReviewTableView reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
		[self.WriteReviewTableView reloadData];
	} 
	else 
	{
		NSLog(@"button is 1");
	}
}

	
-(void)textFieldDidBeginEditing:(UITextField *)sender
{ 
	
	
	if (currTextField) 
	{
		[currTextField release];
	}
	currTextField = [sender retain];
	
	
	//move the main view, so that the keyboard does not hide it.
	if(sender.tag==2)
		[self setViewMovedUp:YES];
	
	
	
	
	//if(sender.tag==30)
//	{
//		self.view.frame = CGRectMake(0,-100 ,320 ,366 );
//	}
	
	if (self.view.frame.origin.y + currTextField.frame.origin.y >= 150) 
	{
		[self setViewMovedUp:YES]; 
	}
	 
	 
}


-(void)keyDown
{
	[currTextField resignFirstResponder];
	
	
	[self setViewMovedUp:NO];
	self.WriteReviewTableView.frame = CGRectMake(0,40,320,366);
	
}



-(void)textFieldDidEndEditing:(UITextField *)textField
{
	if(textField.tag==0)
	{
		writereviewobject.Name=textField.text;
	}
	else if(textField.tag==2)
	{
		writereviewobject.TitleOfReview=textField.text;
	}
	else if(textField.tag==3)
	{
		//reservationobject.NumberOfChildern=textField.text;
	}
	else if(textField.tag==4)
	{
		//reservationobject.ContactName=textField.text;
	}
	else if(textField.tag==5)
	{
		//writereviewobject.TitleOfReview=textField.text;
	}
	
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	self.WriteReviewTableView.frame = CGRectMake(0,0,320,366);
	[self setViewMovedUp:NO];
	return YES;
}

 


- (void)textViewDidBeginEditing:(UITextView *)textView
{
	if(textView.tag==3)
	{
		[self setViewMovedUp:YES];
		//writereviewobject.comment=textView.text;
		//NSLog(@"write object comment is ddddd%@",writereviewobject.comment);
	}
	
	
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
	
	if ([text hasSuffix:@"\n"]) 
	{
		NSLog(@"textView Encountered \n");
		[textView resignFirstResponder];
		//[notesTextView setContentOffset:CGPointMake(0,0) animated:YES];
		[textView setScrollEnabled:YES];
		[self setViewMovedUp:NO];
		return NO;		
	}
	return YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
	if(textView.tag==3)
	{
		writereviewobject.comment=textView.text;
		NSLog(@"write object comment is ddddd%@",writereviewobject.comment);
	}
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)sender
{
	
	 /*
	 if(sender.tag==6)
	 {
	 [myScrollView setContentOffset:CGPointMake(0,130)];
	 
	 UITextField *new_textfield=(UITextField *)sender;
	 if([new_textfield.text length]>7)
	 {
	 return YES;
	 }
	 
	 }
	 */
	
	return YES;
}



-(IBAction) backClicked:(id) sender
{
	[self.navigationController popViewControllerAnimated:YES];
}



//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3]; // if you want to slide up the view
	
	//CGRect rect = self.view.frame;
	CGRect rect=self.WriteReviewTableView.frame;
	if (movedUp)
	{
		// 1. move the view's origin up so that the text field that will be hidden come above the keyboard 
		// 2. increase the size of the view so that the area behind the keyboard is covered up.
		rect.origin.y = -70;//kMin - currTextField.frame.origin.y ;
		
		//[self.myScrollView setScrollsToTop:YES];
		
		
	}
	else
	{
		NSLog(@"%d rect is %d",rect.origin.y);
	
		
		// revert back to the normal state.
		    rect.origin.y =70;				   
  					
		//[self.WriteReviewTableView setFrame:CGRectMake(0,70,320,460)];
		//[self.myScrollView setScrollsToTop:NO];
	}
	//self.view.frame = rect;
		//[self.WriteReviewTableView setFrame:CGRectMake(0,70,320,460)];
	self.WriteReviewTableView.frame=rect;
	[UIView commitAnimations];
}


- (void)keyboardWillShow:(NSNotification *)notif
{
	//keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
	NSLog(@"in key board will show");
	if ([currTextField isFirstResponder] && currTextField.frame.origin.y + self.view.frame.origin.y >= 150)
	{
		[self setViewMovedUp:YES];
	}
	else if (![currTextField isFirstResponder] && currTextField.frame.origin.y  + self.view.frame.origin.y < 150)
	{
		[self setViewMovedUp:NO];
	}
}

- (void)keyboardWillHide:(NSNotification *)notif
{
	NSLog(@"key board will hide");
	//keyboard will be shown now. depending for which textfield is active, move up or move down the view appropriately
	if(self.WriteReviewTableView.frame.origin.y<0)
	{
		[self setViewMovedUp:NO];
	}
	/*
	if (self.view.frame.origin.y < 0 ) {
		NSLog(@"origin < 0 ");
		[self setViewMovedUp:NO];
	}
	*/
}

/*
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	self.ReservationTableView.frame = CGRectMake(0,0,320,366);
	[self setViewMovedUp:NO];
	return YES;
}
*/


//////////////////////////////-table view end delegate methods---------------------///////////////////////
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


- (NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView 
{
	return 1;
}

- (NSInteger) pickerView: (UIPickerView *) pickerView numberOfRowsInComponent: (NSInteger) component 
{
	return 6;
}

- (NSString *) pickerView: (UIPickerView *) pickerView titleForRow: (NSInteger) row forComponent: (NSInteger) component 
{
	if(pickerSelected==1)		
		return [self.FoodQualityRatingArray objectAtIndex:row];
	
	else if(pickerSelected==2)
		return [self.AtmosphereRatingArray objectAtIndex:row];
	
	else if(pickerSelected==3)
		return [self.valueRatingArray objectAtIndex:row];
	
	else if(pickerSelected==4)
		return [self.ServiceRatingArray objectAtIndex:row];


	return nil;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	pickerMoved=1;
	NSLog(@"row = %d",row);
	if(pickerSelected==1)
	{
		if(row==-1)
		{
			row=0; 
		appDelegate.CompleteRating=[NSString stringWithFormat:@"%@", [self.FoodQualityRatingArray objectAtIndex:0]];
			NSLog(@"row isa  %d",row);
		}
		NSLog(@"row is %d a",row);
		//isAdultMoved=YES;
		appDelegate.CompleteRating=[NSString stringWithFormat:@"%@", [self.FoodQualityRatingArray objectAtIndex:row]];
		[self.WriteReviewTableView reloadData];
	}
	/*
	else if(pickerSelected==2)
	{
		if(row==-1)
		{
			row=0; 
			
			appDelegate.AtmosphereRating=[NSString stringWithFormat:@"%@", [self.AtmosphereRatingArray objectAtIndex:0]];
			NSLog(@"row is cd %d",row);
			
		}
		//isChildrenMoved=YES;
		NSLog(@"row is %d dd",row);
		appDelegate.AtmosphereRating=[NSString stringWithFormat:@"%@", [self.AtmosphereRatingArray objectAtIndex:row]];
		
		[self.WriteReviewTableView reloadData];		
	}
	
	
	else if(pickerSelected==3)
	{
		if(row==-1)
		{
			row=0; 
			
			appDelegate.ValueRating=[NSString stringWithFormat:@"%@", [self.valueRatingArray objectAtIndex:0]];
			NSLog(@"row is cd %d",row);
			
		}
		//isChildrenMoved=YES;
		NSLog(@"row is %d dd",row);
		appDelegate.ValueRating=[NSString stringWithFormat:@"%@", [self.valueRatingArray objectAtIndex:row]];
		
		[self.WriteReviewTableView reloadData];		
	}
	
	else if(pickerSelected==4)
	{
		if(row==-1)
		{
			row=0; 
			
			appDelegate.ServiceRating=[NSString stringWithFormat:@"%@", [self.ServiceRatingArray objectAtIndex:0]];
			NSLog(@"row is cd %d",row);
			
		}
		//isChildrenMoved=YES;
		NSLog(@"row is %d dd",row);
		appDelegate.ServiceRating=[NSString stringWithFormat:@"%@", [self.ServiceRatingArray objectAtIndex:row]];
		
		[self.WriteReviewTableView reloadData];		
	}
	
	
	 */
}


/////////////////////////////end of table View Delegate nethods/////////////////////////////////////////////














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


- (void)dealloc 
{
	[FoodQualityRatingArray release];
	[AtmosphereRatingArray release];
	[valueRatingArray release];
	[ServiceRatingArray release];
	[reviewCommentCell release];
	[writereviewcell release];
	[WriteReviewTableView release];
	[ReviewArray release];
	[super dealloc];
}


@end
