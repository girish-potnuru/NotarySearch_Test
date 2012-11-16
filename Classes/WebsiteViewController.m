//
//  WebsiteViewController.m
//  ApunKaBazar
//
//  Created by stellentmac2 on 7/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WebsiteViewController.h"


@implementation WebsiteViewController
@synthesize webUrl;
@synthesize webView;
@synthesize activityIndicator;
@synthesize urlTitle;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.webView.delegate = self;
	
	self.activityIndicator.hidesWhenStopped = YES;
	
	self.urlTitle.text = self.webUrl;
	
	[self.activityIndicator startAnimating];
	//[self performSelector:@selector(loadMapView) withObject:nil afterDelay:0.1];
	[self loadMapView];
	
}


- (void) loadMapView
{
	NSLog(@"urlString: #123#%@#123#",self.webUrl);
	
	NSString *str = @"";
	
	if ([self.webUrl hasPrefix:@"http://"])
	{
		str = self.webUrl;
	}
	else 
	{
		str = [NSString stringWithFormat:@"http://%@",self.webUrl];
	}

	
	NSURL *url = [NSURL URLWithString:str];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:urlRequest];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
	NSLog(@"webViewLoaded");
	[self.activityIndicator stopAnimating];
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	NSLog(@"webViewLoading Failed");
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error!" message:@"Experiencing connection problems" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
	[alert show];
	[alert release];
	[self.activityIndicator stopAnimating];
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

- (IBAction) back: (id) sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)HomeButtonPressed:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
	
}





- (void)dealloc 
{
	[webUrl release];
	[urlTitle release];
	
	if ([self.webView isLoading]) 
	{
		[self.webView stopLoading];
		self.webView.delegate = nil;
	}
	
	[webView release];
	webView = nil;
	
	[activityIndicator release];
	activityIndicator = nil;
    [super dealloc];
}


@end
