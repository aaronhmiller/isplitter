/*
 * Copyright (c) 2008, Aaron H. Miller

 * All rights reserved.

 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * The names of its contributors may not be used to endorse or promote products derived from this software without specific prior written permission.
 */

#import <UIKit/UIButtonBar.h>
#import <UIKit/UITransitionView.h>
#import <LayerKit/LayerKit.h>

@interface SplitsView : UIView {
	
	UITransitionView   *_transitionView;
	UIButtonBar        *_buttonBar;
	UIView			*groupView;
	UIView			*soloView;
	int       currentView;
	int		  barStatus;

	struct CGRect				rect;
	struct CGRect				_offScreenRect;
	struct CGRect				_onScreenRect;	
}

- (id)initWithFrame:(struct CGRect)frame;
- (UIButtonBar *)createButtonBar;
- (void)buttonBarItemTapped:(id)sender;
- (NSArray *)buttonBarItems;
- (void)reloadButtonBar;
- (UITransitionView *)createTransitionView;
- (void)animate;

#define CB_1  0x00
#define CB_2 0x01

extern NSString *kUIButtonBarButtonAction;
extern NSString *kUIButtonBarButtonInfo;
extern NSString *kUIButtonBarButtonInfoOffset;
extern NSString *kUIButtonBarButtonSelectedInfo;
extern NSString *kUIButtonBarButtonStyle;
extern NSString *kUIButtonBarButtonTag;
extern NSString *kUIButtonBarButtonTarget;
extern NSString *kUIButtonBarButtonTitle;
extern NSString *kUIButtonBarButtonTitleVerticalHeight;
extern NSString *kUIButtonBarButtonTitleWidth;
extern NSString *kUIButtonBarButtonType;

@end //@interface SplitsView

