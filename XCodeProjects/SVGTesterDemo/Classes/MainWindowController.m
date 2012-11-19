//
//  MainWindowController.m
//  SVGTester
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MainWindowController.h"
#import <AtoZ/AtoZ.h>
#import <QuartzCore/QuartzCore.h>

@implementation MainWindowController

@synthesize view = _view;

- (id)init {
	self = [super initWithWindowNibName:@"MainWindow"];
	if (self) {
		NSLog(@"hello!");
		__block NSMutableArray *u = [NSMutableArray array];
		[[[NSFileManager defaultManager]contentsOfDirectoryAtPath:[[NSBundle mainBundle]resourcePath] error:nil]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			if ( [[(NSString*)obj pathExtension] isEqualToString:@"svg"]) [u addObject:obj];
		}];
		NSLog(@"Files, %@",u);// [[NSFileManager defaultManager]contentsOfDirectoryAtPath:[[NSBundle mainBundle]resourcePath] error:nil]);

		_names = u;
//		[[NSFileManager defaultManager]contentsOfDirectoryAtPath:[[NSBundle mainBundle]resourcePath] error:nil];// [NSArray arrayWithObjects:@"Monkey.svg", @"Note.svg", nil];
		_currentIndex = 0;
	}
	return self;
}

- (IBAction)next:(id)sender {
	NSString *name = [_names randomElement];// objectAtIndex:_currentIndex];
	AZLOG(name);
	SVGDocument *document = [SVGDocument documentNamed:name];
//	NSImage *u = [NSImage svg2png:_svgpath out:nil];
//	AZLOG(name);
//	__block CAL *o = [document layerTree];
//	NSLog(@"layer: %@ \nTree: %@", do.debugDescription, o.debugLayerTree);
//	NSA* paths = [o.sublayers filter:^BOOL(id object) {
//			AZLOG([object propertiesPlease]);
//				BOOL yea = [object hasProperty:@"path"];//:[CAShapeLayer class]];
//			if (yea) LOG_EXPR(object);
//			return yea;
//	}];
////	[_view2 removeAllSubviews];
//	[_view2 addSubview:[BLKVIEW viewWithFrame:_view2.bounds opaque:YES drawnUsingBlock:^(BNRBlockView *v, NSRect dirtyRect) {
//		NSRectFillWithColor(dirtyRect, RANDOMCOLOR);
//		[paths each:^(id obj) {
////
//		LOG_EXPR( [NSBP bezierPathWithCGPath:[(CASL*)obj path]]);
//		[[NSBP bezierPathWithCGPath:[(CASL*)obj path]]drawWithFill:RANDOMCOLOR andStroke:RANDOMCOLOR];
//		}];
//	}]];

//	[o sublayersBlock:^(CALayer *layer) {
//		layer.bounds = _view2.bounds;
//		layer.position = AZCenterOfRect(_view2.bounds);
//	}];
//	_view2.layer.sublayers = nil;;
//	[_view2.layer addSublayer: o];
//	NSBitmapImageRep *rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
//																	pixelsWide:document.width
//																	pixelsHigh:document.height
//																 bitsPerSample:8
//															   samplesPerPixel:3
//																	  hasAlpha:NO
//																	  isPlanar:NO
//																colorSpaceName:NSCalibratedRGBColorSpace
//																   bytesPerRow:4 * document.width
//																  bitsPerPixel:32];
//	
//	CGContextRef context = [[NSGraphicsContext graphicsContextWithBitmapImageRep:rep] graphicsPort];
//	
//	CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f); // white background
//	CGContextFillRect(context, CGRectMake(0.0f, 0.0f, document.width, document.height));
//	
//	CGContextScaleCTM(context, 1.0f, -1.0f); // flip
//	CGContextTranslateCTM(context, 0.0f, -document.height);
//	
//	[[document layerTree] renderInContext:context];
//	
//	CGImageRef image = CGBitmapContextCreateImage(context);
//	
//	NSBitmapImageRep *rendering = [[NSBitmapImageRep alloc] initWithCGImage:image];
//	CGImageRelease(image);
//	
//	NSString *imageName = [name stringByReplacingOccurrencesOfString:@"svg" withString:@"png"];
//	NSString *file = [[NSBundle mainBundle] pathForImageResource:imageName];
//	
//	NSData *data = [NSData dataWithContentsOfFile:file];
//	NSBitmapImageRep *original = [[NSBitmapImageRep alloc] initWithData:data];
//	
//	[_view compareImage:rendering withOriginal:original];
//
//	if (_currentIndex == [_names count] - 1) {
//		[sender setEnabled:NO];
//	}
//	
//	_currentIndex++;
}

- (void)windowDidLoad {
	[super windowDidLoad];
	[self next:nil];
}

- (IBAction)toggleOverlay:(id)sender {
    NSButton* checkbox = (NSButton*) sender;
    
    if (checkbox.state) {
        [_view showOverlay];
    } else {
        [_view hideOverlay];
    }
}
@end
