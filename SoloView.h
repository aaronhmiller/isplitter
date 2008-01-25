/*
 * Copyright (c) 2008, Aaron H. Miller

 * All rights reserved.

 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * The names of its contributors may not be used to endorse or promote products derived from this software without specific prior written permission.
 */

#import <Foundation/Foundation.h> 
#import <UIKit/CDStructures.h>
#import <UIKit/UINavigationBar.h>
#import <UIKit/UIPreferencesTable.h>
#import <UIKit/UIPreferencesTextTableCell.h>
#import <UIKit/UIHardware.h>
#import <UIKit/UIView.h>
#import <UIKit/UIView-Hierarchy.h>
#import <UIKit/UIKeyboard.h>
#import <UIKit/UITextTraits.h> //had to alter UITextTraits.h to use Foundation/NSObject.h
#import <UIKit/UINavigationItem.h>

/* see how much work UIKit.h saves you??? :) but need to tolerate a compiler error due to similar signatures for becomeFirstResponder
#import <UIKit/UIKit.h>
#import <UIKit/UIPreferencesTable.h>
#import <UIKit/UIPreferencesTextTableCell.h>
*/
#import "iPhoneDefs.h"

@interface SoloView : UIView {
	UINavigationBar 		*navBar;
	UIPreferencesTable 		*table;
	UIPreferencesTextTableCell 	*billCell, *tipPercentCell, *tipAmountCell, *resultCell;
}

-(id)initWithFrame:(struct CGRect)frame;

//Delegate Methods
-(void)tableRowSelected:(NSNotification *)notification;

//DataSource Methods
-(int)numberOfGroupsInPreferencesTable:(UIPreferencesTable *)table;
-(int)preferencesTable:(UIPreferencesTable *)table numberOfRowsInGroup:(int)group;
-(UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)table cellForGroup:(int)group;
-(UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)table cellForRow:(int)row inGroup:(int)group;

@end