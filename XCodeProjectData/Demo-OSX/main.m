//
//  main.m
//  Demo-OSX
//
//  Created by C.W. Betts on 6/7/13.
//  Copyright (c) 2013 C.W. Betts. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SVGKit.h"

int main(int argc, char *argv[])
{
	@autoreleasepool {
		[SVGKit enableLogging];
	}
	
	return NSApplicationMain(argc, (const char **)argv);
	
}
