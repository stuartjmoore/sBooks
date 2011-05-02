//
//  PagesAppDelegate.h
//  Pages
//
//  Created by Stuart Moore on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PagesViewController;

@interface PagesAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PagesViewController *viewController;

@end
