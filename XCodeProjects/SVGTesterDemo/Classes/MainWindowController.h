//
//  MainWindowController.h
//  SVGTester
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import <SVGKit/SVGKit.h>
#import "ComparisonView.h"

@interface MainWindowController : NSWindowController {
  @private
	NSArray *_names;
	NSUInteger _currentIndex;
}

@property (nonatomic, retain) IBOutlet ComparisonView *view;
@property (nonatomic, retain) IBOutlet NSView  *view2;
@property (nonatomic, retain) IBOutlet NSView *drawn;

- (IBAction)next:(id)sender;
- (IBAction)toggleOverlay:(id)sender;

@end
