//
//  SearchViewController.m
//  ApunKaBazar
//
//  Created by stellentmac1 on 7/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import"ASIFormDataRequest.h"
#import"JSON.h"
#import"Restaurant.h"
#import<QuartzCore/QuartzCore.h>
#import"ApunKaBazarAppDelegate.h"
#import"Facility.h"
#import"AddsObject.h"
#import<CoreLocation/CoreLocation.h>
#import"RestaurantDetailViewController.h"
#import"CategoryMenuListCell.h"
#import"IconDownloader.h"
#import"SpecilasObject.h"

@interface SearchViewController()
- (void)startIconDownload:(Restaurant *) object forElement:(NSIndexPath *)indexPath;
- (void)loadImagesForOnscreenRows;
- (void)appImageDidLoad:(NSIndexPath *)indexPath;
@end


@implementation SearchViewController
@synthesize searchBar;
@synthesize SearchTableView;
@synthesize SearchArray;
@synthesize activityIndicator;
@synthesize imageDownloadsInProgress; 
@synthesize tblCell;
@synthesize  count;
@synthesize addsTimer;
@synthesize AddImageView;
@synthesize TopLabel;

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
	/*
	UIImageView* iview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_image.png"]];
	iview.frame = CGRectMake(0, 0, 320, 44);
	[searchBar insertSubview:iview atIndex:1];
	[iview release];
	*/
	self.TopLabel.text=@"Search";
	SearchArray=[[NSMutableArray alloc]init];
	imageDownloadsInProgress=[[NSMutableDictionary alloc]init]; 
	appDelegate=(ApunKaBazarAppDelegate *)[[UIApplication sharedApplication]delegate];
	[self addImagesMethod];
	
}



- (void)doSearch
{
	[self.imageDownloadsInProgress removeAllObjects];
	//http://www.myappdemo.com/ApunKaBazaar/services/searchcategory.php
	NSString *urlString1=[NSString stringWithFormat:@"%@searchcategory.php",URLprefix];
	NSLog(@"%@",urlString1);
	NSURL *url1=[[NSURL alloc] initWithString:urlString1];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url1];
	[request setPostValue:[NSString stringWithFormat:@"%f",appDelegate.currentLocation.latitude]  forKey:@"latt"];
    [request setPostValue:[NSString stringWithFormat:@"%f",appDelegate.currentLocation.longitude] forKey:@"long"];
	[request setPostValue:appDelegate.selectedCategory.categotyId forKey:@"catid"];
    [request setPostValue:self.searchBar.text forKey:@"searchdata"];
 	[request setDelegate:self];
	[request startSynchronous];
	
	[url1 release];
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		NSLog(@"response:%@",response);
		NSData *responseData=[request responseData];
		NSString *responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]autorelease];
		
		NSArray *array = [responseString JSONValue];
		//[responseString release];
		
		//NSArray *array=[results objectForKey:@"menus"];
		NSMutableArray *arr=[[NSMutableArray alloc] init];
		
		for (NSDictionary *dict in array) 
		{
			Restaurant *menu=[[Restaurant alloc] init];
			menu.resid=[dict objectForKey:@"ResId"];
			menu.resname=[dict objectForKey:@"ResName"];
			menu.phoneno=[dict objectForKey:@"Phoneno"];
			menu.address=[dict objectForKey:@"Address"];
			menu.imageURL=[dict objectForKey:@"Image"];
			menu.rating = [dict objectForKey:@"Rating"];
			menu.resDistance = [dict objectForKey:@"distance"];
			menu.Email = [dict objectForKey:@"email"];
			menu.WebSiteUrl = [dict objectForKey:@"website"];
			menu.latitude=[dict objectForKey:@"latt"];
			menu.longitude=[dict objectForKey:@"long"];
			//menu.resCategory = self.selectedCategoryMenu.categoryMenuname;
			NSMutableArray *array=[dict objectForKey:@"facilities"];
			NSLog(@"Array Count is %d",[array count]);
			NSMutableArray *asArray=[[NSMutableArray alloc]init];
			if([array count]>=1)
			{
			for (int i=0;i<[array count];i++)
			{
				Facility *facilityObject=[[Facility alloc]init];
				NSDictionary *dict=[array objectAtIndex:i];
				facilityObject.facilityName=[dict objectForKey:@"facility"];
				facilityObject.facilityImgURL=[dict objectForKey:@"facilityimage"];
				[asArray addObject:facilityObject];
				[facilityObject release];
				
			}
				menu.FacilitiesArray=asArray;
			}
			/*
			NSArray *specialsArray=[dict objectForKey:@"ResName"];
			NSMutableArray *sobjectArray=[[NSMutableArray alloc]init];
			
			for (int i=0;i<[specialsArray count];i++)
			{
				
				SpecilasObject *object=[[SpecilasObject alloc]init];
				 object.Specialisation=[specialsArray objectAtIndex:i];	
				
				[sobjectArray addObject:object];
				[object release];
				
			}
			
			menu.specialisationArray=sobjectArray;
			[sobjectArray release];
			 */
			//[menu.FacilitiesArray addObjectsFromArray:asArray];
			[asArray release];
			NSLog(@"facilities array ppopopopopo count is %d",[menu.FacilitiesArray count]);
			
			[arr addObject:menu];
			[menu release];
		}
		
		
		
		[self.SearchArray removeAllObjects];
		self.SearchArray=arr;
		[arr release];
		
	}
	
	else if(error)
	{
		
		NSLog(@"error description is %@",[error localizedDescription]);
		NSLog(@"error number is %d",[error description]);
		
	}
	
	[self.SearchTableView reloadData];
	[self.activityIndicator stopAnimating];
}

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText {
	[self.searchBar setShowsCancelButton:YES animated:YES];
	// We don't want to do anything until the user clicks 
	// the 'Search' button.
	// If you wanted to display results as the user types 
	// you would do that here.
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	
	
	
	//tableview.hidden=YES;
    // searchBarTextDidBeginEditing is called whenever 
    // focus is given to the UISearchBar
    // call our activate method so that we can do some 
    // additional things when the UISearchBar shows.
    //[self searchBar:searchBar activate:YES];
	//[self.bandTableView reloadData];
	
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    // Clear the search text
    // Deactivate the UISearchBar
    searchBar.text=@"";
	[searchBar resignFirstResponder];
	//[self.bandTableView reloadData];
	[self.searchBar setShowsCancelButton:NO animated:YES];
	//
	//[self searchBar:searchBar activate:NO];
	//[self getData];
	//isSearching=NO;
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	
	//imageDownloadsInProgress = nil;
	//isSearching=YES;
	//self.homeButton.title=@"Back";
	[searchBar resignFirstResponder];
	[self.searchBar setShowsCancelButton:NO animated:YES];
	NSLog(@"search bar text is %@",searchBar.text);
	NSLog(@"search bar text is %@",searchBar.text);
	[self.activityIndicator startAnimating];
	[self performSelector:@selector(doSearch) withObject:nil afterDelay:0.2];
    //[self doSearch];
	//isSearching=YES;
	
}


//////////////-----------------tableview delegate methods------------------//////////////////////////


-(IBAction)back:(id)sender
{
	
	NSArray *iconDownloaders = [imageDownloadsInProgress allValues];
	[iconDownloaders makeObjectsPerformSelector:@selector(cancelDownload)];
	[self.navigationController popViewControllerAnimated:YES];
	
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
	
	return [self.SearchArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	static NSString *MyIdentifier= @"MyIdentifier";
	MyIdentifier = @"CategoryMenuListCell";
	CategoryMenuListCell *cell = (CategoryMenuListCell *) [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	if (cell==nil) 
	{
		[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:self options:nil];
		cell=tblCell;
		
	}	
	
	Restaurant *res=[self.SearchArray objectAtIndex:indexPath.row];
	cell.lblName.text=res.resname;
	//cell.lblAddress.text=res.address;
	
	if([res.address length]>1)
	{
	NSArray *array=[res.address componentsSeparatedByString:@","];
	NSLog(@"array is %@",array);
	
	//NSMutableString *strings=[[NSMutableString alloc]init];
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
			
			//}
			/*	
			 else 
			 {
			 NSString *stringe=[array objectAtIndex:i];
			 [string3 appendString:stringe];
			 [string3 appendString:@","];
			 
			 }*/
			
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
	cell.lblAddress.text=finalString3;
	[string1 release];
	[string3 release];
	}
	else {
		
			cell.lblAddress.text=@"";
		
	}

	
	cell.lblPhone.text=[NSString stringWithFormat:@"Ph:%@",res.phoneno];
	
	// Update Distance
	float dis = [res.resDistance floatValue];
	cell.lblDistance.text = [NSString stringWithFormat:@"%0.2f miles",dis];
	
	
	
	// Update star rating
	float ratingFloat = [res.rating floatValue];
	int	rating = round(ratingFloat);
	NSLog(@"rating: %d, res.rating: %@, ratingDouble: %f, ratingFloat: %f",rating,res.rating,[res.rating doubleValue],[res.rating floatValue]);
	[cell updateRating:rating];
	
	
	
	// Update Res Image
	if ([res.imageURL isEqualToString:@""] || [res.imageURL isKindOfClass:[NSNull class]]||[res.imageURL length]<1) 
	{
		//load dummy url
	}
	else if(!res.picture)
	{
		NSLog(@"no picture");
		if (self.SearchTableView.dragging==NO && self.SearchTableView.decelerating==NO) 
		{
			[self startIconDownload:res forElement:indexPath];
		}
	}
	else 
	{
		CALayer *imageLayer = [CALayer layer];
		imageLayer.frame =CGRectMake(0,0,57, 62);
		imageLayer.cornerRadius = 5.0;
		imageLayer.contents=(id)res.picture.CGImage;
		imageLayer.masksToBounds =YES;
		[cell.img.layer addSublayer:imageLayer];
	}
	
	/*
	NSArray *categoryArray=thisRestaurant.specialisationArray;
	NSMutableString *completeString=[[NSMutableString alloc]init];
	for (int i=0;i<[categoryArray count];i++)
	{
		NSString *CommaString=@",";
		completeString=[categoryArray objectAtIndex:i];
	    [completeString appendString:CommaString];
		
		
	}
    int length=[completeString length];
	NSString *estring=
	*/
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	//NSLog(@"did selct row");
	Restaurant *selectedRes = [self.SearchArray objectAtIndex:indexPath.row];
	RestaurantDetailViewController *viewController = [[RestaurantDetailViewController alloc] initWithNibName:@"RestaurantDetailViewController" bundle:nil];
	[viewController setValue:selectedRes forKey:@"thisRestaurant"];
	//[viewController setValue:self.selectedCategoryMenu.categoryMenuname forKey:@"menuItemName"];
	NSLog(@"selectrd restaunt count is %d",[selectedRes.FacilitiesArray count]);
	[self.navigationController pushViewController:viewController animated:YES];
	[viewController release];
}



//////////////////////------------tableview end of delegate methods-------------------//////////////////

//////////////// Image Downloader Delegate methods here /////////
/////////////////////////////////////////////////////////////////

- (void)startIconDownload:(Restaurant *) object forElement:(NSIndexPath *)indexPath
{
	
	NSLog(@"start icon download");
	IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil)
    {
        iconDownloader = [[IconDownloader alloc] init];
        [iconDownloader setValue:object forKey:@"aRes"]; //.aSong = aSong;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];
    }
	
}


// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
	
    if ([self.SearchArray count] > 0)
    {
		NSArray *visiblePaths = [self.SearchTableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            Restaurant *aRes = (Restaurant *)[self.SearchArray objectAtIndex:indexPath.row];
            
            if (!aRes.picture) // avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:aRes forElement:indexPath];
            }
        }
    }
}



- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
	IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
	if (iconDownloader != nil)
	{
		CategoryMenuListCell *cell=(CategoryMenuListCell*)[self.SearchTableView cellForRowAtIndexPath:indexPath];
		
		if (iconDownloader.aRes.picture)
		{				
			
			Restaurant *res=[self.SearchArray objectAtIndex:indexPath.row];
			res.picture = iconDownloader.aRes.picture;
			//create round rect images
			CALayer *imageLayer = [CALayer layer];
			imageLayer.frame =  CGRectMake(0,0, 57, 62);
			
			imageLayer.cornerRadius = 5.0;
			imageLayer.contents = (id)iconDownloader.aRes.picture.CGImage;
			imageLayer.masksToBounds =YES;
			
			//imageLayer.borderColor=[UIColor colorWithRed:243/255.f green:146/255.f blue:0.f alpha:1].CGColor;
			//imageLayer.borderColor=[UIColor orangeColor].CGColor;
			//imageLayer.borderWidth=3;
			[cell.img.layer addSublayer:imageLayer];
			
		}
	}	
}


#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	//NSLog(@"Top10VC: ScrollView did end dragging");
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	//NSLog(@"Top10VC: ScrollView did end decelerating");
    [self loadImagesForOnscreenRows];
}



/////////////// End of Image Downloader Methods /////////////////
/////////////////////////////////////////////////////////////////

-(IBAction)HomeButtonPressed:(id)sender
{
	NSArray *iconDownloaders = [imageDownloadsInProgress allValues];
	[iconDownloaders makeObjectsPerformSelector:@selector(cancelDownload)];
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





-(void)viewWillAppear:(BOOL)animated
{
	
	self.addsTimer=[NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(addImagesMethod) userInfo:nil repeats:YES];
	
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


- (void)dealloc {
	NSArray *iconDownloaders = [imageDownloadsInProgress allValues];
	[iconDownloaders makeObjectsPerformSelector:@selector(cancelDownload)];
	[imageDownloadsInProgress release];
	[TopLabel release];
	[tblCell release];
	[activityIndicator release];
	[SearchTableView release];
	[searchBar release];
    [super dealloc];
}


@end
