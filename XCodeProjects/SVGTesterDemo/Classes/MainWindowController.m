//
//  MainWindowController.m
//  SVGTester
//
//  Copyright Matt Rajca 2011. All rights reserved.
//

#import "MainWindowController.h"
#import <AtoZ/AtoZ.h>
#import <QuartzCore/QuartzCore.h>

@implementation  DrawnView


- (void) drawRect:(NSRect)dirtyRect

{

	CAL* lay = [self.svg layerTree];
	[lay sublayersBlock:^(CALayer *layer) {
		if ( [layer isKindOfClass:[CAShapeLayerWithHitTest class]]) {
			CGPathRef p = ((CAShapeLayerWithHitTest*)layer).path;
			NSBezierPath *bez = [NSBezierPath bezierPathWithCGPath:p];
			[RANDOMCOLOR setStroke];
			[bez setLineWidth:4];
			[bez stroke];
		}
	}];
}

@end
@implementation MainWindowController
{
CGP dragStart;
CGF deltaX, deltaY;
CATransformLayer *tLayer;
CAL* root;
}

@synthesize view = _view;

- (id)init {
	self = [super initWithWindowNibName:@"MainWindow"];	if (self) {
		NSS* _path  = @"~/Downloads/picol_prerelease_svg_090316/picol_prerelease_svg_090316/";
//	@"/Volumes/2T/ServiceData/git/Iconic/vector/optimized";
//	@"/Volumes/2T/ServiceData/git/Iconic/raster/original/iconic_r0g0b0";
//	@"~/Downloads/11_02_osa_icons_svg";
//	@"/Volumes/2T/ServiceData/www/global/icons/picol_prerelease_svg";
//	@"/Volumes/2T/ServiceData/git/WebKit/LayoutTests/svg/custom";
//	@"/Volumes/2T/ServiceData/git/WebKit/LayoutTests/svg/W3C-SVG-1.1";
	_names = [[AZFILEMANAGER pathsOfContentsOfDirectory:_path] filter:^BOOL(id object) { return [object endsWith:@".svg"]; }];


//	[AZStopwatch named:@"mono" block:^{
//	[[NSImage contactSheetWith:[NSIMG monoIcons] sized:AZSizeFromDimension(256) spaced:AZSizeFromDimension(25) columns:10 withName: YES]openInPreview];
//	}];
//	[AZStopwatch named:@"svgrender" block:^{
//	NSA* rendered = [_names map:^id(id obj) {
//		SVGDocument *document = [SVGDocument documentWithContentsOfFile:obj];
//		return [[document layerTree]renderToImageWithContextSize:AZSizeFromDimension(256)];
//	}];
//	[[NSImage contactSheetWith:rendered sized:AZSizeFromDimension(256) spaced:AZSizeFromDimension(25) columns:10 withName: YES]openInPreview];
//	}];

	} return self;
}

- (void) awakeFromNib  {	[_view2 setWantsLayer:YES];   }

- (void) mouseDown:(NSEvent *)theEvent
{	
	dragStart 	= [_view2 convertPoint:theEvent.locationInWindow fromView:nil];
	CAL* l	 	= [_view2.layer hitTest:[_view2 layerPoint:theEvent]];
	LOG_EXPR(l);
	if ([l isKindOfClass:[ CAShapeLayerWithHitTest class]]){
		if ( theEvent.clickCount == 2) {
			NSLog(@"DoubleClick");
			[((CAShapeLayerWithHitTest*)l) animate:@"transform.rotation.x" toFloat:DEG2RAD(360) time:2];
		}
		((CAShapeLayerWithHitTest*)l).fillColor = cgRANDOMCOLOR;
	}
}
- (void)mouseDragged:(NSEvent *)theEvent
{
	CGPoint point = [_view2 convertPoint:theEvent.locationInWindow fromView:nil];
	deltaX = (point.x - dragStart.x)/200;
	deltaY = -(point.y - dragStart.y)/200;
	[root orientWithX:deltaX andY:deltaY];
//	angleX+deltaX) andY:(angleY+deltaY)];
}


- (IBAction)next:(id)sender {

	[AZStopwatch named:@"svg" block:^{

		NSString *name = [_names randomElement];
		AZLOG(name);
		SVGDocument *document = [SVGDocument documentWithContentsOfFile:name];
		self.drawn.svg = document;
		[self.drawn setNeedsDisplay:YES];
		[root removeFromSuperlayer];
		root = [document layerTree];
	//	tLayer = [CATransformLayer layer];
		root.position = _view2.center;
		root.anchorPoint = (CGP){.5,.5};
		root.transform = CATransform3DMakeScale(5, -5, 1);
	//	tLayer.sublayers = @[root];
		[_view2.layer addSublayer:root];
	}];
	
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

//	[SVGDocument documentNamed:name];
//	NSImage *u = [NSImage svg2png:_svgpath out:nil];
//	AZLOG(name);
//	document.bounds = [_view2 bounds];

//	NSLog(@"layer: %@ \nTree: %@... subCount:%ld",document.properties, o.debugLayerTree, o.sublayers.count);
//	NSMA* paths = [NSMA array];
//	[root sublayersBlock:^(CALayer *layer) {
//		[layer isKindOfClass:[CAShapeLayerWithHitTest class]] ? [paths addObject:layer] : nil;
//	}];

//				BOOL yea = [object hasProperty:@"path"];//:[CAShapeLayer class]];
//			if (yea) LOG_EXPR(object);
//			return yea;

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
//		o.bounds = _drawn.bounds;
//		o.position = AZCenterOfRect(_drawn.bounds);
//	}];


//	tLayer.frame = _view2.bounds;
//	CAT3D cat = CATransform3DMakeRotation(M_PI / 2.0f, 0, -1, 0);//CATransform3DScale(, 1, -1, 1);
//	cat = CATransform3DMakeTranslation(_view2.width/2, _view2.height/2, 0);
//	cat = CATransform3DConcat(cat, CATransform3DMakeScale(5, 5, 1));
//	cat = CATransform3DConcat(cat, CATransform3DMakeRotation(DEG2RAD(180), 0, 1, 0));

//	tLayer.sublayerTransform = cat;
//	root[@"transform.scale.y"] = [NSN numberWithFloat:5];

//	[_view2.layer sublayersBlock:^(CALayer *layer) {
//		AZLOG(layer.properties);
//	}];

/*	[_drawn removeAllSubviews];

//	__block NSBP* thePath = nil;
	NSAffineTransform *transform = [NSAffineTransform transform];
	NSAffineTransform *scale		 = [NSAffineTransform transform];
	NSAffineTransform *location  = [NSAffineTransform transform];
    [scale scaleBy:5];
	[location translateXBy:_drawn.width/2 yBy:_drawn.height/2];

	[transform appendTransform:location];
	[transform appendTransform:scale];

	[_drawn addSubview:[BLKVIEW viewWithFrame:_drawn.frame opaque:YES drawnUsingBlock:^(BNRBlockView *view, NSRect dirtyRect) {
		[paths each:^(CAShapeLayerWithHitTest* pathlayer) {
			NSBP *localP = [NSBP bezierPathWithCGPath:[pathlayer path]];
			LOG_EXPR(localP);
			[transform transformBezierPath:localP];
//			[localP setLineWidth:pathlayer.lineWidth];
			[[NSColor colorWithCGColor:pathlayer.fillColor] setFill];
			[localP fill];
//			[[NSColor colorWithCGColor:pathlayer.strokeColor] setStroke];
//			[localP stroke];

		}];
	}]];
*/
//	[_drawn setNeedsDisplay:YES];
/*	__block NSBP* thePath = nil;
	[paths each:^(CAShapeLayerWithHitTest* pathlayer) {

		if (thePath) [thePath az_appendPath:[NSBP bezierPathWithCGPath:[(CASL*)pathlayer path]]];
		else thePath = [NSBP bezierPathWithCGPath:[(CASL*)pathlayer path]];
		[thePath closePath];
	}];
	[_drawn addSubview:[BLKVIEW viewWithFrame:_drawn.frame opaque:YES drawnUsingBlock:^(BNRBlockView *view, NSRect dirtyRect) {

		[[thePath scaledToFrame:_drawn.frame]drawWithFill:RANDOMCOLOR andStroke:RANDOMCOLOR];
	}]];
*/
//AZLOG([obj properties]);
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


//		__block NSMutableArray *u = [NSMutableArray array];
//		[[[NSFileManager defaultManager]contentsOfDirectoryAtPath:[[NSBundle mainBundle]resourcePath] error:nil]enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//			if ( [[(NSString*)obj pathExtension] isEqualToString:@"svg"]) [u addObject:obj];
//		}];
//		NSLog(@"Files, %@",u);// [[NSFileManager defaultManager]contentsOfDirectoryAtPath:[[NSBundle mainBundle]resourcePath] error:nil]);

//		_names = u;
//		[[NSFileManager defaultManager]contentsOfDirectoryAtPath:[[NSBundle mainBundle]resourcePath] error:nil];// [NSArray arrayWithObjects:@"Monkey.svg", @"Note.svg", nil];
//_currentIndex = 0;
