//
//  BookView.m
//  Pages
//
//  Created by Stuart Moore on 5/2/11.
//  Copyright 2011 Intentionally Blank. All rights reserved.
//

#import "BookView.h"


@implementation BookView

@synthesize delegate;

- (void) initialize 
{
}

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
		[self initialize];
    }
    return self;
}

- (void) awakeFromNib 
{
	[super awakeFromNib];
    
	[self initialize];
}

- (void)dealloc 
{	
    [super dealloc];
}


- (void) reloadData 
{
}

- (id<BookViewDataSource>) dataSource 
{
	return nil;	
}

- (void) setDataSource:(id<BookViewDataSource>)value 
{
}

@end
