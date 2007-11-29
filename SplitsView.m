/*
 * Copyright (c) 2007, Aaron H. Miller

 * All rights reserved.

 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * The names of its contributors may not be used to endorse or promote products derived from this software without specific prior written permission.
 */

#import "SplitsView.h"

@implementation SplitsView

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	CGRect rect = [UIHardware fullScreenApplicationContentRect];
	rect.origin.x = rect.origin.y = 0.0f;
	
	table = [[UIPreferencesTable alloc] initWithFrame:CGRectMake(0.0f, UI_TOP_NAVIGATION_BAR_HEIGHT, 320.0f, 415.0f)];
	[table setDataSource:self];
	[table setDelegate:self];
	[table reloadData];
	
	navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width,UI_TOP_NAVIGATION_BAR_HEIGHT)];
	[navBar showButtonsWithLeftTitle:@"Clear" rightTitle:@"Calculate"];
	[navBar enableAnimation];
	[navBar setDelegate: self];
 	[navBar pushNavigationItem: [[UINavigationItem alloc] initWithTitle: @"Splitter"]];

	keyboard = [[UIKeyboard alloc] initWithDefaultSize];

	billCell = [[UIPreferencesTextTableCell alloc] init];
	[billCell setTitle:@"Amount of bill:"];
	[billCell setPlaceHolderValue:@"54.37"];
	[[billCell textField] setPreferredKeyboardType: 1];

	tipCell = [[UIPreferencesTextTableCell alloc] init];
	[tipCell setTitle:@"Tip percentage:"];
	[tipCell setPlaceHolderValue:@"18%"];
	[tipCell setValueSuffix:@"%"];
	[[tipCell textField] setPreferredKeyboardType: 1];

	splitCell = [[UIPreferencesTextTableCell alloc] init];
	[splitCell setTitle:@"Split bill amongst:"];
	[splitCell setPlaceHolderValue:@"4"];
	[[splitCell textField] setReturnKeyType: 1]; //GO button
	[[splitCell textField] setAutoEnablesReturnKey: YES];
	[[splitCell textField] setPreferredKeyboardType: 1];
	[splitCell setReturnAction:@selector(calcIt)];
	[splitCell setTarget: self];

	resultCell = [[UIPreferencesTextTableCell alloc] init];
	[resultCell setTitle:@"Each party owes:"];
	[resultCell setPlaceHolderValue:@"16.04"];

	versionCell = [[UIPreferencesTextTableCell alloc] init];

	[self addSubview:navBar];
	[self addSubview:table];

	return self;
}

- (void)calcIt
{
	float result = ([[billCell value] floatValue] * (1 + ([[tipCell value] floatValue]/100.0))) / [[splitCell value] floatValue];
	[resultCell setValue:[NSString stringWithFormat:@"%.2f", result]];
	[table setKeyboardVisible:NO];
}

// ----------------Delegate Methods----------------

- (void)tableRowSelected:(NSNotification*)notification;
{
	NSLog(@"selected row %d", [table selectedRow]);
	//note: grouping seems to insert empty rows, adjust indices accordingly to trigger selectedRow
}

- (void)navigationBar:(UINavigationBar*)navBar buttonClicked:(int)button 
{
	switch (button) 
	{
		case 0:
		{
			NSLog(@"left");
			[self calcIt];
			break;
		}
		case 1:
		{
			NSLog(@"right");
			[billCell setValue:@""]; [billCell setPlaceHolderValue:@""];
			[tipCell setValue:@""]; [tipCell setPlaceHolderValue:@""];
			[splitCell setValue:@""]; [splitCell setPlaceHolderValue:@""];
			[resultCell setValue:@""]; [resultCell setPlaceHolderValue:@""];
			[table setKeyboardVisible:NO];
			break;
		}
	}
}

// ---------------Datasource Methods---------------
- (int)numberOfGroupsInPreferencesTable:(UIPreferencesTable *)table
{
	return 3;
}

- (int)preferencesTable:(UIPreferencesTable *)table numberOfRowsInGroup:(int)group
{
	switch (group)
	{
		case 0: return 3;
		case 1: return 1;
		case 2: return 1;
	}
}

- (UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)table cellForGroup:(int)group
{
	UIPreferencesTableCell *cell = [[UIPreferencesTableCell alloc] init];
	return [cell autorelease];
}

- (UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)table cellForRow:(int)row inGroup:(int)group
{ 
	if (group == 0) {
		switch (row) 
		{
			case 0: return billCell;
			case 1: return tipCell;
			case 2: return splitCell;
		}
	}
	else if (group == 1) 
	{
		[[resultCell textField] setEnabled:NO];
		return resultCell;
	}
	else if (group == 2) 
	{
		[versionCell setEnabled:NO];
//		NSString *version = [NSString stringWithFormat:@"Version 0.3.2 %C 2007 Aaron Miller", 0xA9];
		NSString *version = [NSString stringWithFormat:@""];
		[versionCell setTitle:version];
		[versionCell setDrawsBackground:NO];
		[versionCell _setDrawAsLabel:YES];
		return versionCell;
	}
}

@end