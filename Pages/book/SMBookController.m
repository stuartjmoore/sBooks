//
//  BookViewController.m
//  Pages
//
//  Created by Stuart Moore on 5/2/11.
//  Copyright 2011 Intentionally Blank. All rights reserved.
//

#import "SMBookController.h"

@implementation SMBookController

- (void)awakeFromNib
{
    if(page < [self numberOfPages])
        [self loadPage:page atIndex:1];
    
    if(page+1 < [self numberOfPages])
        [self loadPage:page+1 atIndex:0];
}

- (void)loadPage:(int)pageNumber atIndex:(int)i
{
    [[self view] insertSubview:[self pageAtIndex:pageNumber].view atIndex:i];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{	
	if(animateTimer)
		return;
	
	if(pageTurning)
		return;
    
    pageTurning = NO;
	
	CGPoint point = [[touches anyObject] locationInView:self.view];
	
	if(point.x > touchFrame.size.width/2)
	{
        if(page == [self numberOfPages]-1)
            point = CGPointMake(point.x + (pageFrame.size.width - point.x) * 7 / 8, point.y);
        
        pageAdvancing = YES;
	}
	else
	{
		if(page > 0)
		{
			pageAdvancing = NO;
			
			if(page < [self numberOfPages])
				[[[self.view subviews] objectAtIndex:0] removeFromSuperview];
			
            [self loadPage:page-1 atIndex:1];
			
		}
		else
			return;
	}
    
    pageTurning = YES;
    [self initPageCurl];
    [self renderPageCurlAt:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if(!pageTurning)
		return;
	
	CGPoint point = [[touches anyObject] locationInView:self.view];
    
    if(page == [self numberOfPages]-1 && pageAdvancing)
        point = CGPointMake(point.x + (pageFrame.size.width - point.x) * 7 / 8, point.y);
    
	[self renderPageCurlAt:point];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if(!pageTurning)
		return;
    
	CGPoint point = [[touches anyObject] locationInView:self.view];
	
    if(page == [self numberOfPages]-1 && pageAdvancing)
        point = CGPointMake(point.x + (pageFrame.size.width - point.x) * 7 / 8, point.y);
    
    [self destroyPageCurl];
    
	pageTurning = NO;
	
    
	if(point.x > touchFrame.size.width/2)
	{			
		if(!pageAdvancing)
			page--;
        
        [self turnToPage:page fromPoint:point toPoint:CGPointMake(pageFrame.size.width, point.y)];
	}
	else
	{
		if(pageAdvancing)
			page++;
        
        [self turnToPage:page fromPoint:point toPoint:CGPointMake(pageFrame.origin.x, point.y)];
	}
}


- (void)initPageCurl
{
	UIView *topPage = [[[self view] subviews] lastObject];
    UIView *backOfPage = [[UIView alloc] init];
    [[backOfPage layer] setFrame:CGRectMake(0, 8, pageFrame.size.width, pageFrame.size.height)];
    
    [backOfPage setBackgroundColor:[UIColor whiteColor]];
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
	[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *backOfPageImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    CGImageRef backOfPageImageRef = [backOfPageImage CGImage];
    [[backOfPage layer] setContents:(id)backOfPageImageRef];
    [[backOfPage layer] setContentsGravity:kCAGravityLeft];
    
	[backOfPage layer].shouldRasterize = YES;
    [backOfPage layer].shadowColor = [UIColor blackColor].CGColor;
    [backOfPage layer].shadowOpacity = 0.4;
    [backOfPage layer].shadowRadius = 7;
    [backOfPage layer].shadowOffset = CGSizeMake(-pageFrame.origin.x, -pageFrame.origin.y);
    CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, nil, pageFrame);
	[backOfPage layer].shadowPath = path;
    
    
    CALayer *whiteOverlay = [[CALayer alloc] init];
    [whiteOverlay setFrame:backOfPage.bounds];
    [whiteOverlay setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.8].CGColor];
    [[backOfPage layer] addSublayer:whiteOverlay];
    [whiteOverlay release];
    
    
    [topPage addSubview:backOfPage];
    [backOfPage release];
    
    float diagPageFrameHeight = sqrt(pageFrame.size.height*pageFrame.size.height
                                     +pageFrame.size.width*pageFrame.size.width);
    
    UIView *backOfPageFold = [[UIView alloc] init];
    [[backOfPageFold layer] setFrame:CGRectMake(pageFrame.origin.x, pageFrame.origin.y, 80, diagPageFrameHeight)];
    CALayer *foldMask = [[CALayer alloc] init];
    [foldMask setBackgroundColor:[UIColor blackColor].CGColor];
    [foldMask setFrame:pageFrame];
    [[backOfPageFold layer] setMask:nil];
    [[backOfPageFold layer] setMask:foldMask];
    [foldMask release];
    CAGradientLayer *maskGradient = [CAGradientLayer layer];
    [maskGradient setStartPoint:CGPointMake(0.5, 0.5)];
    [maskGradient setEndPoint:CGPointMake(1, 0.5)];
    [maskGradient setColors:[NSArray arrayWithObjects: (id)[[UIColor clearColor] CGColor],
                             (id)[[[UIColor blackColor] colorWithAlphaComponent:0.4] CGColor], nil]];
    [maskGradient setFrame:backOfPageFold.bounds];
    [[backOfPageFold layer] insertSublayer:maskGradient atIndex:0];
    [[self view] addSubview:backOfPageFold];
    [backOfPageFold release];
    
    UIView *backOfPageShadow = [[UIView alloc] init];
    [[backOfPageShadow layer] setFrame:CGRectMake(pageFrame.origin.x, pageFrame.origin.y, 140, diagPageFrameHeight)];
    CALayer *shadowMask = [[CALayer alloc] init];
    [shadowMask setBackgroundColor:[UIColor blackColor].CGColor];
    [shadowMask setFrame:pageFrame];
    [[backOfPageShadow layer] setMask:nil];
    [[backOfPageShadow layer] setMask:shadowMask];
    [shadowMask release];
    CAGradientLayer *shadowGradient = [CAGradientLayer layer];
    [shadowGradient setStartPoint:CGPointMake(0, 0.5)];
    [shadowGradient setEndPoint:CGPointMake(0.5, 0.5)];
    [shadowGradient setColors:[NSArray arrayWithObjects:
                               (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
                               (id)[[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor],
                               (id)[[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor],
                               (id)[[UIColor clearColor] CGColor], nil]];						
    [shadowGradient setFrame:backOfPageShadow.bounds];
    [[backOfPageShadow layer] insertSublayer:shadowGradient atIndex:0];
    [[self view] addSubview:backOfPageShadow];
    [backOfPageShadow release];
}

- (void)renderPageCurlAt:(CGPoint)point
{
	[CATransaction begin]; 
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	
	float maxAngle = 3.14/7;
	UIView *topPage = [[[self view] subviews] objectAtIndex:[[[self view] subviews] count]-3];
	
    float angle = (2*(point.y/touchFrame.size.height)-1) * maxAngle;
	angle *= point.x/pageFrame.size.width;
	float toa = tan(angle - 3.14/2);
	float topX = point.x - point.y/toa;
	float botX = point.x + (pageFrame.size.height-point.y)/toa;
	
	CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, -pageFrame.origin.x, -pageFrame.origin.y);
    CGPathAddLineToPoint(path, nil, topX, -pageFrame.origin.y);
    CGPathAddLineToPoint(path, nil, topX, 0);
    CGPathAddLineToPoint(path, nil, botX, pageFrame.size.height);
    CGPathAddLineToPoint(path, nil, botX, self.view.frame.size.height);
    CGPathAddLineToPoint(path, nil, -pageFrame.origin.x, self.view.frame.size.height);
	CGPathCloseSubpath(path);
	
	CAShapeLayer *topPageMask = [[CAShapeLayer alloc] init];
	[topPageMask setPath:path];
	[[topPage layer] setMask:nil];
	[[topPage layer] setMask:topPageMask];
	[topPageMask release];
    CGPathRelease(path);
    
	
	UIView *backOfPage = [[topPage subviews] lastObject];
	[[backOfPage layer] setAnchorPoint:CGPointMake((pageFrame.size.width-botX)/pageFrame.size.width, 1)];
	[[backOfPage layer] setPosition:CGPointMake(botX, pageFrame.size.height)];
    
    CATransform3D scale = CATransform3DMakeScale(-1, 1, 1);
    CATransform3D translate = CATransform3DMakeTranslation(botX-(pageFrame.size.width-botX), 0, 0);
    CATransform3D scaleAndTrans = CATransform3DConcat(scale, translate);
    CATransform3D rotate = CATransform3DMakeRotation(angle*2, 0, 0, 1);
    [[backOfPage layer] setTransform:CATransform3DConcat(scaleAndTrans, rotate)];
	
    //[backOfPage layer].shadowRadius = fabs(point.x/pageFrame.size.width-1)*7 + 5;
    //[backOfPage layer].shadowOffset = CGSizeMake(fabs(point.x/pageFrame.size.width-1)*-30, 0);
    
    float diagPageFrameHeight = sqrt(pageFrame.size.height*pageFrame.size.height+pageFrame.size.width*pageFrame.size.width);
    
	UIView *backOfPageFold = [[[self view] subviews] objectAtIndex:[[[self view] subviews] count]-2];
	if(point.y < pageFrame.size.height/2)
	{
		[[backOfPageFold layer] setAnchorPoint:CGPointMake(1, 0)];
		[[backOfPageFold layer] setPosition:CGPointMake(topX, pageFrame.origin.y)];
	}
	else
	{
		[[backOfPageFold layer] setAnchorPoint:CGPointMake(1, 1)];
		[[backOfPageFold layer] setPosition:CGPointMake(botX, pageFrame.origin.y+pageFrame.size.height)];
	}
	[[backOfPageFold layer] setTransform:CATransform3DMakeRotation(angle, 0, 0, 1)];
	
	CALayer *foldMask = [[backOfPageFold layer] mask];
    [foldMask setTransform:CATransform3DMakeRotation(angle, 0, 0, 1)];
	if(point.y < pageFrame.size.height/2)
    {
        [foldMask setAnchorPoint:CGPointMake(1, 0)];
        [foldMask setPosition:CGPointMake(80, -1)];
        [foldMask setBounds:CGRectMake(0, 0, pageFrame.size.width-topX+2, pageFrame.size.height)];
        // -1 and +2 are pushing for the pixels
    }
    else if(point.y > pageFrame.size.height/2)
    {
        [foldMask setAnchorPoint:CGPointMake(1, 1)];
        [foldMask setPosition:CGPointMake(80, diagPageFrameHeight)];
        [foldMask setBounds:CGRectMake(pageFrame.origin.x, pageFrame.origin.y, 
                                       pageFrame.size.width-botX, pageFrame.size.height)];
	}
	
	UIView *backOfPageShadow = [[[self view] subviews] objectAtIndex:[[[self view] subviews] count]-1];
	if(point.y < pageFrame.size.height/2)
	{
		[[backOfPageShadow layer] setAnchorPoint:CGPointMake(0, 0)];
		[[backOfPageShadow layer] setPosition:CGPointMake(topX, pageFrame.origin.y)];
	}
	else
	{
		[[backOfPageShadow layer] setAnchorPoint:CGPointMake(0, 1)];
		[[backOfPageShadow layer] setPosition:CGPointMake(botX, pageFrame.origin.y+pageFrame.size.height)];
	}
	[[backOfPageShadow layer] setTransform:CATransform3DMakeRotation(angle, 0, 0, 1)];
	
	CALayer *shadowMask = [[backOfPageShadow layer] mask];
    [shadowMask setTransform:CATransform3DMakeRotation(-angle, 0, 0, 1)];
	if(point.y < pageFrame.size.height/2)
    {
        [shadowMask setAnchorPoint:CGPointMake(0, 0)];
        [shadowMask setPosition:CGPointMake(0, 0)];
        [shadowMask setBounds:CGRectMake(pageFrame.origin.x, pageFrame.origin.y, 
                                         pageFrame.size.width-topX, pageFrame.size.height)];
    }
    else
    {
        [shadowMask setAnchorPoint:CGPointMake(0, 1)];
        [shadowMask setPosition:CGPointMake(0, diagPageFrameHeight)];
        [shadowMask setBounds:CGRectMake(pageFrame.origin.x, pageFrame.origin.y, 
                                         pageFrame.size.width-botX, pageFrame.size.height)];
	}
    
    
	[CATransaction commit];
}

- (void)destroyPageCurl
{
    UIView *backOfPageShadow = [[[self view] subviews] lastObject];
    [backOfPageShadow removeFromSuperview];
    
    UIView *backOfPageFold = [[[self view] subviews] lastObject];
    [backOfPageFold removeFromSuperview];
    
	UIView *topPage = [[[self view] subviews] lastObject];
    UIView *backOfPage = [[topPage subviews] lastObject];
    [backOfPage removeFromSuperview];
    
    [[[[self.view subviews] objectAtIndex:0] layer] setMask:nil];
    if([[self.view subviews] count] > 1)
        [[[[self.view subviews] objectAtIndex:1] layer] setMask:nil];
}


- (void)turnToRelativePage:(int)relativePageNumber
{
    [self turnToPage:page+relativePageNumber];
}

- (void)turnToPage:(int)pageNumber
{
	if(pageNumber < page)
		[self turnToPage:pageNumber 
               fromPoint:CGPointMake(pageFrame.origin.x, 3*pageFrame.size.height/4) 
                 toPoint:CGPointMake(pageFrame.size.width, 3*pageFrame.size.height/4)];
	else if(pageNumber > page)
		[self turnToPage:pageNumber 
               fromPoint:CGPointMake(pageFrame.size.width, pageFrame.size.height/4)
                 toPoint:CGPointMake(pageFrame.origin.x, pageFrame.size.height/4)];
}

- (void)turnToPage:(int)pageNumber fromPoint:(CGPoint)point
{
	if(pageNumber < page)
		[self turnToPage:pageNumber 
               fromPoint:point 
                 toPoint:CGPointMake(pageFrame.size.width, 3*pageFrame.size.height/4)];
	else if(pageNumber > page)
		[self turnToPage:pageNumber 
               fromPoint:point
                 toPoint:CGPointMake(pageFrame.origin.x, pageFrame.size.height/4)];
}

- (void)turnToPage:(int)pageNumber fromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint
{
    if(pageNumber >= [self numberOfPages])
        return;
    
    if(pageNumber < 0)
        return;
    
	if(pageTurning)
		return;
	
	if(animateTimer)
		return;
    
    if(startPoint.x < pageFrame.origin.x)
        startPoint = CGPointMake(pageFrame.origin.x+1, startPoint.y);
    if(startPoint.x > pageFrame.size.width)
        startPoint = CGPointMake(pageFrame.size.width-1, startPoint.y);
    
    if(startPoint.y < pageFrame.origin.y)
        startPoint = CGPointMake(startPoint.x, pageFrame.origin.y+1);
    if(startPoint.y > pageFrame.size.height)
        startPoint = CGPointMake(startPoint.x, pageFrame.size.height-1);
	
	animatePageNumber = pageNumber;
	animateStartPoint = startPoint;
    animateCurrentPoint = startPoint;
    animateEndPoint = endPoint;
	
	if(animatePageNumber < page)
	{
		if(page < [self numberOfPages])
			[[[self.view subviews] objectAtIndex:0] removeFromSuperview];
		
        [self loadPage:animatePageNumber atIndex:1];
	}
	else if(animatePageNumber > page)
	{
		if(page < [self numberOfPages])
			[[[self.view subviews] objectAtIndex:0] removeFromSuperview];
		
        [self loadPage:animatePageNumber atIndex:0];
	}
    
    [self initPageCurl];
	[self renderPageCurlAt:animateCurrentPoint];
	animateTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self
												  selector:@selector(animatePageCurl:)
												  userInfo:nil repeats:YES];
}

- (void)animatePageCurl:(NSTimer*)timer
{	
    float speed = 50;  // should be FPS'd
    
    if((animateStartPoint.x < animateEndPoint.x && animateCurrentPoint.x >= animateEndPoint.x)
    || (animateStartPoint.x > animateEndPoint.x && animateCurrentPoint.x <= animateEndPoint.x))
	{
		[self destroyPageCurl];
        
		if(animatePageNumber < page)
		{
			[[[self.view subviews] objectAtIndex:0] removeFromSuperview];
            
            [self loadPage:animatePageNumber atIndex:0];
		}
		else if(animatePageNumber > page || (animatePageNumber == page && animateCurrentPoint.x < touchFrame.size.width/2))
		{
			[[[self.view subviews] objectAtIndex:1] removeFromSuperview];
			
			if(animatePageNumber < [self numberOfPages])
                [self loadPage:animatePageNumber+1 atIndex:0];
		}
		
		page = animatePageNumber;
		
		[animateTimer invalidate];
		animateTimer = nil;
		return;
	}
	else if(animatePageNumber < page)
		animateCurrentPoint = CGPointMake(animateCurrentPoint.x+speed, animateCurrentPoint.y);
	else if(animatePageNumber > page)
		animateCurrentPoint = CGPointMake(animateCurrentPoint.x-speed, animateCurrentPoint.y);
	else if(animatePageNumber == page)
	{
		if(animateCurrentPoint.x > touchFrame.size.width/2)
            animateCurrentPoint = CGPointMake(animateCurrentPoint.x+speed, animateCurrentPoint.y);
		else
            animateCurrentPoint = CGPointMake(animateCurrentPoint.x-speed, animateCurrentPoint.y);
	}
    
	[self renderPageCurlAt:animateCurrentPoint];
}


- (void)dealloc 
{
    [super dealloc];
}


- (NSUInteger)numberOfPages
{
	return 0;
}

- (UIViewController*)pageAtIndex:(NSUInteger)index
{
    return nil;
}

@end
