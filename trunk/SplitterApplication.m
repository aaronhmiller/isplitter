/*
 * Copyright (c) 2008, Aaron H. Miller

 * All rights reserved.

 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * The names of its contributors may not be used to endorse or promote products derived from this software without specific prior written permission.
 */

#import "SplitterApplication.h"

@implementation SplitterApplication

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

	struct CGRect rect = [UIHardware fullScreenApplicationContentRect];
	rect.origin.x = rect.origin.y = 0.0f;

	// for transparent status bar, set height to zero so that the
	// main view can start at the top of the screen.
//	[self setStatusBarMode:1 orientation:0 duration:0.0f fenceID:0]; //mode transparent
	
	window = [[UIWindow alloc] initWithContentRect: rect];
	splitsView = [[SplitsView alloc] initWithFrame: rect];
 
	[window orderFront: self];
	[window makeKey: self];
	[window _setHidden: NO];
	[window setContentView: splitsView];
}

- (void)dealloc
{
	[window release];
	[splitsView release];
	[super dealloc];	
}
@end
