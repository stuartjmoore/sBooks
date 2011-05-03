//
//  TOCViewController.h
//  Pages
//
//  Created by Stuart Moore on 5/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMBookController.h"


@interface PageViewController : UIViewController 
{
    IBOutlet UILabel *textLabel;
    IBOutlet UILabel *pageNumLabel;
    
	SMBookController *parentController;
}

@property (retain, nonatomic) UILabel *textLabel;
@property (retain, nonatomic) UILabel *pageNumLabel;
@property (retain, nonatomic) UIViewController *parentController;

- (IBAction)turnToNextPage:(id)sender;
- (IBAction)turnToFirstPage:(id)sender;
- (IBAction)turnToPrevPage:(id)sender;

@end
