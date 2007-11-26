/*
 * Copyright (c) 2007, Aaron H. Miller

 * All rights reserved.

 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * The names of its contributors may not be used to endorse or promote products derived from this software without specific prior written permission.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <UIKit/UIView.h>
#import <UIKit/UIPreferencesTable.h>
#import <UIKit/UIPreferencesTableCell.h>
#import <UIKit/UIPreferencesTextTableCell.h>
#import <UIKit/UIPreferencesDeleteTableCell.h>
#import <UIKit/UIKeyboard.h>
#import <UIKit/UINavigationItem.h>
#import <UIKit/UITextField.h>
#import "iPhoneDefs.h"


@interface SplitsView : UIView {
	UINavigationBar 		*navBar;
	UIKeyboard			*keyboard;
	UIPreferencesTable 		*table;
	UIPreferencesTextTableCell 	*billCell, *tipCell, *splitCell, *resultCell, *versionCell;
}

-(id)initWithFrame:(struct CGRect)frame;
-(void)reloadData;

//Delegate Methods
-(void)tableRowSelected:(NSNotification *)notification;

//DataSource Methods
-(int)numberOfGroupsInPreferencesTable:(UIPreferencesTable *)table;
-(int)preferencesTable:(UIPreferencesTable *)table numberOfRowsInGroup:(int)group;
-(UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)table cellForGroup:(int)group;
-(UIPreferencesTableCell *)preferencesTable:(UIPreferencesTable *)table cellForRow:(int)row inGroup:(int)group;

@end