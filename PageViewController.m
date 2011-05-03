//
//  PageViewController.m
//  Pages
//
//  Created by Stuart Moore on 5/2/11.
//  Copyright 2011 Intentionally Blank. All rights reserved.
//

#import "PageViewController.h"

@implementation PageViewController

@synthesize textLabel, pageNumLabel, parentController;



- (IBAction)turnToNextPage:(id)sender
{
    [parentController turnToRelativePage:1];
}

- (IBAction)turnToFirstPage:(id)sender
{
    [parentController turnToPage:0];
}

- (IBAction)turnToPrevPage:(id)sender
{
    [parentController turnToRelativePage:-1];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
