//
//  AddsWebViewController.m
//  ApunKaBazar
//
//  Created by stellentmac1 on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddsWebViewController.h"


@implementation AddsWebViewController

@synthesize AddsWebView;
@synthesize webUrlString;
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
	
	NSLog(@"in view did load of addswebview controller");
	NSLog(@"url string is %@",self.webUrlString);
	AddsWebView.delegate=self;
	[self loadWebPage];
	
}

-(IBAction)backButton:(id)sender
{
	
	[self.navigationController popViewControllerAnimated:YES];
}


-(void)loadWebPage
{
	NSLog(@"weburl string is %@",self.webUrlString);
	
	NSLog(@"in loadwebpages");
	// trimming the url if any extra spaces exist
	NSString *trimmedString = [self.webUrlString stringByTrimmingCharactersInSet:
							   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	
	//adding percentescape characters if any spaces found
	trimmedString=[trimmedString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	
	
	NSURL *url=[NSURL URLWithString:trimmedString];
	
	NSURLRequest *request=[NSURLRequest requestWithURL:url];
	
	[self.AddsWebView loadRequest:request];
	
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
	printf("\n started");
	//CGRect *center;
	//center=CGRectMake(self.view.frame.origin.x/2 self.view.frame.origin.y/2, 30, 30);
	self.spinner= [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle
				   :UIActivityIndicatorViewStyleWhiteLarge];
	
	[spinner setBackgroundColor:[UIColor blackColor]];
	self.spinner.frame=CGRectMake(150,190, 20, 20);
	[self.spinner setBackgroundColor:[UIColor grayColor]];
	self.spinner.tag =2;
	[self.AddsWebView addSubview:self.spinner]; 
	[self.spinner startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	printf("\n stopped");
	UIActivityIndicatorView *tmpimg = (UIActivityIndicatorView *)[webView viewWithTag:2];
	[tmpimg stopAnimating];
	
	[tmpimg removeFromSuperview];
	[self.spinner stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[self.spinner stopAnimating];
	NSLog(@"webview load failed:%@",[error localizedDescription]);
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


- (void)dealloc 
{
	[AddsWebView release];
	[spinner release];
	[webUrlString release];
    [super dealloc];
}


@end
