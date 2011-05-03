//
//  BookView.h
//  Pages
//
//  Created by Stuart Moore on 5/2/11.
//  Copyright 2011 Intentionally Blank. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BookViewDataSource;
@protocol BookViewDelegate;

@interface BookView : UIView 
{
	id<BookViewDelegate> delegate;
}

@property (assign) id<BookViewDataSource> dataSource;
@property (assign) id<BookViewDelegate> delegate;

@end


@protocol BookViewDataSource <NSObject>

- (NSUInteger)numberOfPages;
- (UIViewController*)pageAtIndex:(NSUInteger)index;

@end


@protocol BookViewDelegate <NSObject>
@optional
//pageWillTurn etc.
@end