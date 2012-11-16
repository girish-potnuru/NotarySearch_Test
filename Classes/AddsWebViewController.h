//
//  AddsWebViewController.h
//  ApunKaBazar
//
//  Created by stellentmac1 on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddsWebViewController : UIViewController<UIWebViewDelegate,UIApplicationDelegate>
{
	
	UIWebView *AddsWebView;
	NSString *webUrlString;
	UIActivityIndicatorView *spinner;
	

}
@property(nonatomic,retain)UIActivityIndicatorView *spinner;
@property(nonatomic,retain)IBOutlet UIWebView *AddsWebView;
@property(nonatomic,retain)	NSString *webUrlString;
-(IBAction)backButton:(id)sender;

@end
