//
//  ReviewsPageViewController.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 6/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ReviewsPageViewController.h"
#import "Review.h"
#import "ReviewCell.h"
#import "ASIFormDataRequest.h"
#import "JSON.h"
#import <Quartzcore/QuartzCore.h>
#import "HeaderCell.h"
#import "Restaurant.h"
#import "WriteReviewViewController.h"
#import"ApunKaBazarAppDelegate.h"

#define ReviewCell_descLabel_width 290
#define ReviewCell_descLabel_y 67

@interface ReviewsPageViewController()

- (void) resetTheView;
- (void) startLoadingCellImage: (NSString *) imageUrl;
@end


@implementation ReviewsPageViewController
@synthesize tblView;
@synthesize tableArray;
@synthesize reviewCell;
@synthesize reviewHeaderCell;
@synthesize whiteBGView;
@synthesize adView;
@synthesize menuItemName;
@synthesize menuNameLabel;
@synthesize thisRestaurant; 
@synthesize placeImage;
@synthesize CompleteRating;


- (IBAction) writeReview:(id) sender
{
	WriteReviewViewController *viewController = [[WriteReviewViewController alloc] initWithNibName:@"WriteReviewViewController" bundle:nil];
	[viewController setValue:self.thisRestaurant forKey:@"thisRestaurant"];
	[self.navigationController pushViewController:viewController animated:YES];
	//[viewController release];
}


- (void) viewDidLoad
{
	[super viewDidLoad];
	NSLog(@"ReviewsPageViewController");
	self.navigationItem.title = thisRestaurant.resCategory;
	appDelegate=[(ApunKaBazarAppDelegate *)[UIApplication sharedApplication]delegate];
	
	self.tableArray = [[NSMutableArray alloc] init];
	self.whiteBGView.layer.cornerRadius = 5.0;
	self.tblView.separatorColor = [UIColor brownColor];
	
	self.menuNameLabel.text =thisRestaurant.resname;

	
	UIBarButtonItem *writeReviewButton = [[UIBarButtonItem alloc] initWithTitle:@"Write Review" style:UIBarButtonItemStyleDone target:self action:@selector(writeReview)];
	self.navigationItem.rightBarButtonItem = writeReviewButton;
	[writeReviewButton release];
	//[self performSelector:@selector(getTableData) withObject:nil afterDelay:0.2];
	// Since we are using a NavigationController, the view's frame deforms. 
	// so readjusting the view's frame
	//[self resetTheView];
	
	
	
}

-(void)viewWillAppear:(BOOL)animated
{
	NSLog(@"ReviewsPageViewController");

	[self.tableArray removeAllObjects];
	if(appDelegate.IsWriteReviewPage=YES)
	{
		[self performSelector:@selector(getTableData) withObject:nil afterDelay:0.2];
		appDelegate.IsWriteReviewPage=NO;
	}	
	
}
- (void) resetTheView
{
	CGRect viewFrame = self.view.frame;
	viewFrame.origin.y = self.navigationController.navigationBar.frame.size.height;
	viewFrame.size.height = 460 - self.navigationController.navigationBar.frame.size.height;
	self.view.frame = viewFrame;
	
	CGRect adViewFrame = self.adView.frame;
	adViewFrame.size.height = 48.0;
	adViewFrame.origin.y = viewFrame.size.height - adViewFrame.size.height;
	self.adView.frame = adViewFrame;
	
	CGRect whiteBGViewFrame = self.whiteBGView.frame;
	whiteBGViewFrame.origin.y = 47.0;
	whiteBGViewFrame.size.height = adViewFrame.origin.y - whiteBGViewFrame.origin.y - 5.0;
	self.whiteBGView.frame = whiteBGViewFrame;
	
	CGRect tblViewFrame = self.tblView.frame;
	tblViewFrame.origin.y = whiteBGViewFrame.origin.y + 5.0;
	tblViewFrame.size.height = whiteBGViewFrame.size.height - 10.0;
	self.tblView.frame = tblViewFrame;
	
}

- (void) getTableData
{
	
	
	
	NSString *urlString = [NSString stringWithFormat:@"%@getreview.php?restaurantid=%@",URLprefix,self.thisRestaurant.resid];
	NSURL *url = [NSURL URLWithString:urlString];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	request.delegate = self;
	[request startSynchronous];
	
	NSError *error = [request error];
	if(!error)
	{
		
		
		NSString *response = [request responseString];
		NSLog(@"Response:%@",response);
		
		NSData *responseData=[request responseData];
		
		NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
		
	     NSDictionary *dict=[responseString JSONValue];
			
	NSArray *reviews=[dict objectForKey:@"Ratings"];
	NSString *CompleteRat=[dict objectForKey:@"Rating"];
	NSLog(@"json array is %@",reviews);
	for (NSDictionary *dict in reviews) 
	{
		Review *aReview = [[Review alloc] init];
		aReview.reviewId = [dict objectForKey:@"ReviewId"];
		aReview.reviewerName = [dict objectForKey:@"ReviewerName"];
		aReview.reviewTitle = [dict objectForKey:@"ReviewTitle"];
		aReview.reviewDesc = [dict objectForKey:@"ReviewDesc"];
		aReview.reviewDate = [dict objectForKey:@"ReviewDate"];
		aReview.userRating=[dict objectForKey:@"Rate"];
		aReview.CompleteHotelRating=CompleteRat;
		[self.tableArray addObject:aReview];
		[aReview release];
	}
	self.CompleteRating=[dict objectForKey:@"Rating"];
	
	[self.tblView reloadData];
	}
	
	
	
	
}

- (void) requestFinished:(ASIHTTPRequest *)request
{
	if (request == imgRequest) 
	{
		NSData *imgData = [request responseData];
		
		imgRequest.delegate = nil;
		imgRequest = nil;
		
		UIImage *image = [UIImage imageWithData:imgData];
		if(image)
		{
			self.placeImage = image;
		}
		
		else {
			self.placeImage=[UIImage imageNamed:@"no-image.png"];
		}

		
		[self.tblView reloadData];
		
		return;
	}
	
	/*
	NSString *jsonString = [request responseString];
	
	asiRequest.delegate = nil;
	asiRequest = nil;
	
	NSDictionary *dict = [jsonString JSONValue];
	
	NSArray *reviews=[dict objectForKey:@"Ratings"];
	NSString *CompleteRat=[dict objectForKey:@"Rating"];
	NSLog(@"json array is %@",reviews);
	for (NSDictionary *dict in reviews) 
	{
		Review *aReview = [[Review alloc] init];
		aReview.reviewId = [dict objectForKey:@"ReviewId"];
		aReview.reviewerName = [dict objectForKey:@"ReviewerName"];
		aReview.reviewTitle = [dict objectForKey:@"ReviewTitle"];
		aReview.reviewDesc = [dict objectForKey:@"ReviewDesc"];
		aReview.reviewDate = [dict objectForKey:@"ReviewDate"];
		aReview.userRating=[dict objectForKey:@"Rate"];
		aReview.CompleteHotelRating=CompleteRat;
		[self.tableArray addObject:aReview];
		[aReview release];
	}
	self.CompleteRating=[dict objectForKey:@"Rating"];
	
	[self.tblView reloadData];
	*/
}

- (void) requestFailed:(ASIHTTPRequest *)request
{
	if (request == imgRequest) 
	{
		imgRequest.delegate = nil;
		imgRequest = nil;
	}
	/*
	else if (request == asiRequest) 
	{
		asiRequest.delegate = nil;
		asiRequest = nil;
	}
	 */
}

#pragma mark UITableView Delegate & Datasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex 
{
	return [self.tableArray count] + 1; // no of reviews in table + 1 (Hotel heading cell)
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{

	if (indexPath.row == 0) 
	{
		HeaderCell *cell = (HeaderCell *)[tableView dequeueReusableCellWithIdentifier:@"headerCell"];
		
		if (cell == nil) 
		{
			[[NSBundle mainBundle] loadNibNamed:@"ReviewHeaderCell" owner:self options:nil];
			cell = reviewHeaderCell;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		}
		
		if (self.placeImage == nil && imgRequest == nil) 
		{
			[self startLoadingCellImage:thisRestaurant.imageURL];
		}
		else 
		{
			if (self.placeImage) // That is image is loaded
			{
				CALayer *layer = [CALayer layer];
				layer.frame = CGRectMake(0, 0, cell.placeImage.frame.size.width, cell.placeImage.frame.size.height);
				layer.contents = (id)self.placeImage.CGImage;
				layer.cornerRadius = 5.0;
				[cell.placeImage.layer addSublayer:layer];
			}
			else
			{
				
				[cell.placeImage setImage:[UIImage imageNamed:@"no-image"]];
				
				// Show Dummy image here			
			}

		}

		NSMutableString *phstring=[[NSMutableString alloc]initWithString:@"Ph:"];
		[phstring appendString:thisRestaurant.phoneno];
		cell.placePh.textAlignment=UITextAlignmentLeft;
		cell.placePh.text =phstring;
		//[phstring release];
		cell.placeName.text = thisRestaurant.resname;
						
		
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
		
		NSString *string4=[string3 substringToIndex:lenght-1];
		NSLog(@"String 3 is %@",string3);
		cell.placeAddress.text = string4;
		
		cell.placeAddress.numberOfLines = 0;
			
		}
		else {
			cell.placeAddress.text = @"";
		}

		
		float floatRating=[thisRestaurant.rating floatValue];
		int  Rating=round(floatRating);
		NSLog(@"rating complete is %d",Rating);

		if(Rating ==1)
		{
			UIImageView *imageView=(UIImageView *)[cell viewWithTag:1];
			[imageView setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
			//[imageView setHidden:YES];
			
		}
		
		
		if(Rating ==2)
		{
			for (int i=1;i<=2;i++)
			{
				UIImageView *imageView=(UIImageView *)[cell viewWithTag:i];
				[imageView setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
				//[imageView setHidden:YES];
				
			}
		}
		
		if(Rating ==3)
		{
			for (int i=1;i<=3;i++)
			{
				UIImageView *imageView=(UIImageView *)[cell viewWithTag:i];
				[imageView setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
				//[imageView setHidden:YES];
				
			}
			
			
		}
		
		if(Rating ==4)
		{
			for (int i=1;i<=4;i++)
			{
				UIImageView *imageView=(UIImageView *)[cell viewWithTag:i];
				[imageView setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
				//[imageView setHidden:YES];
				
			}
			
			
		}
		if(Rating ==5)
		{
			for (int i=1;i<=5;i++)
			{
				UIImageView *imageView=(UIImageView *)[cell viewWithTag:i];
				[imageView setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
				//[imageView setHidden:YES];
			}
			
		}
		
		
		// Update Distance
		float dis = [thisRestaurant.resDistance floatValue];
		cell.placeDistance.text = [NSString stringWithFormat:@"%0.2f mi",dis];
		//cell.placeDistance.text=string;
		//[string release];
		
		
		return cell;
	}
	
	
	ReviewCell *cell = (ReviewCell *)[tableView dequeueReusableCellWithIdentifier:@"ReviewtblCell1"];
	
	if (cell == nil) 
	{
		[[NSBundle mainBundle] loadNibNamed:@"ReviewCell" owner:self options:nil];
		cell = reviewCell;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	Review *cellReview = [self.tableArray objectAtIndex:(indexPath.row - 1)];
	
	NSString *datejson=cellReview.reviewDate;
	NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
	[dateFormatter setDateFormat:@"MM/dd/yyyy"];
	NSDate *dates=[dateFormatter dateFromString:datejson];
	[dateFormatter setDateFormat:@"dd MMMM,yyyy"];
	NSString *stringDate=[dateFormatter stringFromDate:dates];
	cell.dateLabel.text=stringDate;
	
	if(!([cellReview.reviewerName isKindOfClass:[NSNull class]]))
	{
	cell.NameLabel.text=cellReview.reviewerName;
	}
    if(!([cellReview.reviewTitle isKindOfClass:[NSNull class]]))
	{
		cell.TitleLabel.text=cellReview.reviewTitle;
	}
	
	if(!([cellReview.reviewDesc isKindOfClass:[NSNull class]]))
	{
		// Update descLabel Frame
		NSString *reviewDesc= cellReview.reviewDesc;
		cell.reviewDescLabel.text = reviewDesc;
		cell.reviewDescLabel.numberOfLines = 0;
		UIFont *cellFont=cell.reviewDescLabel.font;
		CGSize constraintSize = CGSizeMake(ReviewCell_descLabel_width ,9999999999);
		CGSize txtViewSize = [reviewDesc sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
		
		CGRect descLabelFrame = cell.reviewDescLabel.frame;
		descLabelFrame.size = txtViewSize;
		cell.reviewDescLabel.frame = descLabelFrame;
	}
	
		
	// Update Star Rating
	float floatRating=[cellReview.userRating floatValue];
	int  Rating=round(floatRating);

	/////////////////////////////--------------------------------------////////////////////////////
	if(Rating ==1)
	{
		UIImageView *imageView=(UIImageView *)[cell viewWithTag:1];
		[imageView setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
	}
	else if(Rating ==2)
	{
		for (int i=1;i<=2;i++)
		{
			UIImageView *imageView=(UIImageView *)[cell viewWithTag:i];
			[imageView setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
		}
	}
	else if(Rating == 3)
	{
		for (int i=1;i<=3;i++)
		{
			UIImageView *imageView=(UIImageView *)[cell viewWithTag:i];
			[imageView setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
		}
	}
	else if(Rating ==4)
	{
		for (int i=1;i<=4;i++)
		{
			UIImageView *imageView=(UIImageView *)[cell viewWithTag:i];
			[imageView setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
		}
	}
	else if(Rating ==5)
	{
		for (int i=1;i<=5;i++)
		{
			UIImageView *imageView=(UIImageView *)[cell viewWithTag:i];
			[imageView setImage:[UIImage imageNamed:@"Rating_yellow.png"]];
		}
	}
	
	//////////////////////---------------------closing of rating---------------------////////////////////////
	

	return cell;
	
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) 
	{
		
		return 120;
	}
	
	Review *cellReview = [self.tableArray objectAtIndex:(indexPath.row - 1)];
	
	if (![cellReview.reviewDesc isKindOfClass:[NSNull class]]) 
	{
		NSString *reviewDesc= cellReview.reviewDesc;
		UIFont *cellFont = [UIFont systemFontOfSize:14.0];
		CGSize constraintSize = CGSizeMake(ReviewCell_descLabel_width ,9999999999);
		CGSize txtViewSize = [reviewDesc sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
		
		float height = ReviewCell_descLabel_y + txtViewSize.height + 5.0;
		NSLog(@"y: %d height: %f",ReviewCell_descLabel_y,height);
		
		return height;
	}
	else 
	{
		return ReviewCell_descLabel_y + 21.0 + 5.0;
	}

}


- (void) startLoadingCellImage: (NSString *) imageUrl
{
	NSURL *url = [NSURL URLWithString:imageUrl];
	imgRequest = [ASIFormDataRequest requestWithURL:url];
	imgRequest.delegate = self;
	[imgRequest startAsynchronous];
}

-(IBAction) backClicked:(id) sender{

	[self.navigationController popViewControllerAnimated:YES];
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


- (void)dealloc 
{
	if (asiRequest) 
	{
		asiRequest.delegate = nil;
		[asiRequest cancel];
		asiRequest = nil;
	}
	
	if (imgRequest) 
	{
		imgRequest.delegate = nil;
		[imgRequest cancel];
		imgRequest = nil;
	}
	
	[menuItemName release];
	[tableArray release];
	[placeImage release];
	[thisRestaurant release];
	
	[menuNameLabel release];
	menuNameLabel = nil;
	[adView release];
	adView = nil;
	[tblView release];
	tblView = nil;
	[reviewCell release];
	reviewCell = nil;
	[reviewHeaderCell release];
	reviewHeaderCell = nil;
	[whiteBGView release];
	whiteBGView = nil;
    
	[super dealloc];
}


@end
