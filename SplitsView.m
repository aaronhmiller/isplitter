/*
 * Copyright (c) 2008, Aaron H. Miller

 * All rights reserved.

 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * The names of its contributors may not be used to endorse or promote products derived from this software without specific prior written permission.
 */

#import "SplitsView.h"
#import "GroupView.h"
#import "SoloView.h"
/*
 * SplitsView
 */
@implementation SplitsView

-(id)initWithFrame:(CGRect)frame
{
	if ((self == [super initWithFrame:frame])!=nil)
	{
		barStatus = 1;

		rect = [UIHardware fullScreenApplicationContentRect];
		_offScreenRect = frame;
		_onScreenRect = frame;
		_onScreenRect.origin.x = 0.0f;
		rect.origin.x = rect.origin.y = 0.0f;

		groupView = [ [ GroupView alloc ] initWithFrame:/*CGRectMake(0,0,320,460)*/frame];
		soloView = [ [ SoloView alloc ] initWithFrame:frame];
				
		_transitionView = [ self createTransitionView ];
		_buttonBar = [ self createButtonBar ];

		[ self addSubview: _transitionView ];
		[_transitionView transition:6 toView: groupView];
		[ groupView addSubview: _buttonBar]; //key to proper keyboard behavior...otherwise, kb behind buttonBar
	}
	return self;
}

- (UITransitionView *)createTransitionView
{
	UITransitionView *transitionView = [ [ UITransitionView alloc ] initWithFrame:rect];
	return transitionView;
}

- (UIButtonBar *)createButtonBar
{
	UIButtonBar *buttonBar;
	buttonBar = [ [ UIButtonBar alloc ]
	                initInView: self
	                withFrame: CGRectMake(0.0f, 411.0f, 320.0f, 49.0f)
	                withItemList: [ self buttonBarItems ] ];
	[buttonBar setDelegate:self];
	[buttonBar setBarStyle:1];
	[buttonBar setButtonBarTrackingMode: 2];

	int buttons[2] = {1, 2};
	[buttonBar registerButtonGroup:0 withButtons:buttons withCount: 2];
	[buttonBar showButtonGroup: 0 withDuration: 0.0f];

	[ buttonBar showSelectionForButton: 1];

	return buttonBar;
}

- (NSArray *)buttonBarItems
{
	return [ NSArray arrayWithObjects:
	[ NSDictionary dictionaryWithObjectsAndKeys:
	@"buttonBarItemTapped:", kUIButtonBarButtonAction,
	@"group.png", kUIButtonBarButtonInfo,
	@"group_selected.png", kUIButtonBarButtonSelectedInfo,
	[ NSNumber numberWithInt: 1], kUIButtonBarButtonTag,
	self, kUIButtonBarButtonTarget,
	@"Group", kUIButtonBarButtonTitle,
	@"0", kUIButtonBarButtonType,
	nil
	],

	[ NSDictionary dictionaryWithObjectsAndKeys:
	@"buttonBarItemTapped:", kUIButtonBarButtonAction,
	@"solo.png", kUIButtonBarButtonInfo,
	@"solo_selected.png", kUIButtonBarButtonSelectedInfo,
	[ NSNumber numberWithInt: 2], kUIButtonBarButtonTag,
	self, kUIButtonBarButtonTarget,
	@"Solo", kUIButtonBarButtonTitle,
	@"0", kUIButtonBarButtonType,
	nil
	],
	nil
	];
}

- (void)buttonBarItemTapped:(id) sender
{
	int button = [ sender tag ];
	switch (button)
	{
	case 1:
		if (currentView == CB_1)
		{}
		else
		{	
			[self animate];
			[ groupView addSubview: _buttonBar]; //so keyboard in front
			[ _transitionView transition:0 toView:groupView ];
			currentView = CB_1;
		}
		break;
	case 2:
		if (currentView == CB_2)
		{}
		else
		{
			[self animate];
			[ soloView addSubview: _buttonBar]; //so keyboard in front
			[ _transitionView transition:0 toView:soloView ];
			currentView = CB_2;
		}
		break;
	}
}

- (void)reloadButtonBar
{
	[ _buttonBar removeFromSuperview ];
	[ _buttonBar release ];
	_buttonBar = [ self createButtonBar ];
}

// LayerKit animation (cred to drunknbass!!! and thanks pumpkin)
-(void)animate
{
	LKAnimation *animation = [LKTransition animation];
	[animation setType: @"swirl"];
	[animation setTimingFunction: [LKTimingFunction functionWithName: @"easeInEaseOut"]];
	[animation setFillMode: @"extended"];
	[animation setTransitionFlags: 3]; //makes smoother
	[animation setDuration: 10];
	[animation setSpeed:0.35];
	[[self _layer] addAnimation: animation forKey: 0];
}

- (void)dealloc
{
	[_buttonBar release];
	[_transitionView release];
	[soloView release];
	[groupView release];
	[super dealloc];	
}
@end //@implementation SplitsView


