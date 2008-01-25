/*
 * Copyright (c) 2008, Aaron H. Miller

 * All rights reserved.

 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * The names of its contributors may not be used to endorse or promote products derived from this software without specific prior written permission.
 */

#import "SoloView.h"

@implementation SoloView

-(id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	CGRect rect = [UIHardware fullScreenApplicationContentRect];
	rect.origin.x = rect.origin.y = 0.0f;

	table = [[UIPreferencesTable alloc] initWithFrame:CGRectMake(0.0f, UI_TOP_NAVIGATION_BAR_HEIGHT, 320.0f, rect.size.height - UI_TOP_NAVIGATION_BAR_HEIGHT)];
	[table setDataSource:self];
	[table setDelegate:self];
	[table reloadData]; //needed when flipping between views

	navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width,UI_TOP_NAVIGATION_BAR_HEIGHT)];
	[navBar showButtonsWithLeftTitle:@"Clear" rightTitle:@"Calculate"];
	[navBar enableAnimation];
	[navBar setDelegate: self];
	[navBar pushNavigationItem: [[UINavigationItem alloc] initWithTitle: @"Solo Check"]];

	billCell = [[UIPreferencesTextTableCell alloc] init];
	[billCell setTitle:@"Amount of bill:"];
	[billCell setPlaceHolderValue:@"8.36"];
	[[billCell textField] setReturnKeyType: 4]; //NEXT button
	[[billCell textField] setPreferredKeyboardType: 1];

	tipPercentCell = [[UIPreferencesTextTableCell alloc] init];
	[tipPercentCell setTitle:@"Tip percentage:"];
	[tipPercentCell setPlaceHolderValue:@"20%"];
	[tipPercentCell setValueSuffix:@"%"];
	[[tipPercentCell textField] setPreferredKeyboardType: 1];
	[[tipPercentCell textField] setReturnKeyType: 1]; //GO button
	[[tipPercentCell textField] setAutoEnablesReturnKey: YES]; //only enabled if there's data
	[tipPercentCell setReturnAction:@selector(calcIt)]; //causes default keyboard layout to show on return action
	[tipPercentCell setTarget: self];

	tipAmountCell = [[UIPreferencesTextTableCell alloc] init];
	[tipAmountCell setTitle:@"Amount of tip:"];
	[tipAmountCell setPlaceHolderValue:@"1.67"];

	resultCell = [[UIPreferencesTextTableCell alloc] init];
	[resultCell setTitle:@"Total (with tip):"];
	[resultCell setPlaceHolderValue:@"10.03"];

	[self addSubview:navBar];
	[self addSubview:table];

	return self;
}

- (void)calcIt
{
	float result = [[billCell value] floatValue] * (1 + ([[tipPercentCell value] floatValue]/100.0));
	[resultCell setValue:[NSString stringWithFormat:@"%.2f", result]];
	float tipAmt = [[resultCell value] floatValue] - [[billCell value] floatValue];
	[tipAmountCell setValue:[NSString stringWithFormat:@"%.2f", tipAmt]];
	[table setKeyboardVisible:NO]; //cosmetic bug -> shows default layout as it's hiding when using selector...see selector note
	//happens with YouTube app too, so not sweating this one now...
}

// ----------------Delegate Methods----------------

- (void)tableRowSelected:(NSNotification*)notification;
{
//	NSLog(@"selected row %d", [table selectedRow]);
	[[[table cellAtRow: [table selectedRow] column: 0] textField] becomeFirstResponder]; //enables touch row to edit!
	//note: grouping seems to insert empty rows, adjust indices accordingly 
	//to trigger appropriate selectedRow
}

- (void)navigationBar:(UINavigationBar*)navBar buttonClicked:(int)button
{
	switch (button)
	{
		case 0:
		{
			[self calcIt];
			break;
		}
		case 1:
		{
			[billCell setValue:@""]; [billCell setPlaceHolderValue:@""];
			[tipPercentCell setValue:@""]; [tipPercentCell setPlaceHolderValue:@""];
			[tipAmountCell setValue:@""]; [tipAmountCell setPlaceHolderValue:@""];
			[resultCell setValue:@""]; [resultCell setPlaceHolderValue:@""];
			[table setKeyboardVisible:NO];
			break;
		}
	}
}

// ---------------Datasource Methods---------------
- (int)numberOfGroupsInPreferencesTable:(UIPreferencesTable *)table
{
	return 2;
}

- (int)preferencesTable:(UIPreferencesTable *)table numberOfRowsInGroup:(int)group
{
	switch (group)
	{
		case 0: return 2;
		case 1: return 2;
	}
}

- (UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)_table cellForGroup:(int)group
{ //might NOT be implemented properly!!! cell with focus unselectable when nav bar used 
  //until another member of group is selected or view swirled
//	UIPreferencesTableCell *cell = [[UIPreferencesTableCell alloc] init];
//	return [cell autorelease];
	return nil;
}

- (UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)table cellForRow:(int)row inGroup:(int)group
{
	if (group == 0)
	{
		switch (row)
		{
			case 0: return billCell;
			case 1: return tipPercentCell;
		}
	}
	else if (group == 1)
	{
		switch (row)
		{
			case 0:
			{
				[[tipAmountCell textField] setEnabled:NO];
				return tipAmountCell;
			}
			case 1:
			{
				[[resultCell textField] setEnabled:NO];
				return resultCell;
			}
		}
	}
}

- (void)dealloc
{
	[table release];
	[navBar release];
	[billCell release];
	[tipPercentCell release];
	[tipAmountCell release];
	[resultCell release];
	[super dealloc];
}

@end