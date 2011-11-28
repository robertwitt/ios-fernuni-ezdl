//
//  DocumentLinkViewController.m
//  ezDL
//
//  Created by Robert Witt on 28.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DocumentLinkViewController.h"

@implementation DocumentLinkViewController

@synthesize backItem = _backItem;
@synthesize forwardItem = _forwardItem;
@synthesize safariItem = _safariItem;
@synthesize linkTextField = _linkTextField;
@synthesize linkWebView = _linkWebView;
@synthesize displayedLink = _displayedLink;
@synthesize delegate = _delegate;

#pragma mark Managing the View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.linkWebView loadRequest:[NSURLRequest requestWithURL:self.displayedLink]];
}

- (void)viewDidUnload
{
    self.backItem = nil;
    self.forwardItem = nil;
    self.safariItem = nil;
    self.linkTextField = nil;
    self.linkWebView = nil;
    self.displayedLink = nil;
    self.delegate = nil;
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.linkTextField.text = self.displayedLink.absoluteString;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)done
{
    [self.delegate doneWithdocumentLinkViewController:self];
}

#pragma mark Managing the Web View

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self startNetworkActivity];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopNetworkActivity];
    
    self.linkTextField.text = webView.request.URL.absoluteString;
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
    self.safariItem.enabled = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self stopNetworkActivity];
    
    [self showSimpleAlertWithTitle:NSLocalizedString(@"Error Occured", nil) 
                           message:error.localizedDescription
                               tag:0];
}

- (IBAction)goBack
{
    [self.linkWebView goBack];
}

- (IBAction)goForward
{
    [self.linkWebView goForward];
}

- (IBAction)openInSafari
{
    [self openURL:self.linkWebView.request.URL];
}

@end
