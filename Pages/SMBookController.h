//
//  BookViewController.h
//  Pages
//
//  Created by Stuart Moore on 5/2/11.
//  Copyright 2011 Intentionally Blank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>
#import <QuartzCore/QuartzCore.h>
#import "BookView.h"

@interface SMBookController : UIViewController <BookViewDataSource, BookViewDelegate> 
{
    int page;
	bool pageAdvancing, pageTurning;
	
	CGRect pageFrame, touchFrame;
	
	NSTimer *animateTimer;
	int animatePageNumber;
	CGPoint animateStartPoint,
    animateCurrentPoint,
    animateEndPoint;
}

- (void)loadPage:(int)pageNumber atIndex:(int)i;

- (void)initPageCurl;
- (void)renderPageCurlAt:(CGPoint)point;
- (void)destroyPageCurl;

- (void)turnToRelativePage:(int)relativePageNumber;
- (void)turnToPage:(int)pageNumber;
- (void)turnToPage:(int)pageNumber fromPoint:(CGPoint)point;
- (void)turnToPage:(int)pageNumber fromPoint:(CGPoint)point toPoint:(CGPoint)endPoint;
- (void)animatePageCurl:(NSTimer*)timer;

@end
