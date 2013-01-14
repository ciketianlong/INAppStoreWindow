//
//  SampleAppAppDelegate.m
//  SampleApp
//
//  Created by Indragie Karunaratne on 11-02-23.
//  Copyright 2011 Indragie Karunaratne. All rights reserved.
//

#import "SampleAppAppDelegate.h"
#import "SampleWindowController.h"
#import "INWindowButton.h"

@implementation SampleAppAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.windowControllers = [NSMutableArray array];
    // The class of the window has been set in INAppStoreWindow in Interface Builder
    self.window.trafficLightButtonsLeftMargin = 7.0;
    self.window.fullScreenButtonRightMargin = 7.0;   
    self.window.centerFullScreenButton = YES;
    self.window.titleBarHeight = 60.0;
    
    // set checkboxes
    self.centerFullScreen.state = self.window.centerFullScreenButton;
    self.centerTrafficLight.state = self.window.centerTrafficLightButtons;
    self.verticalTrafficLight.state = self.window.verticalTrafficLightButtons;
    self.showsBaselineSeparator.state = self.window.showsBaselineSeparator;
    self.fullScreenRightMarginSlider.doubleValue = self.window.fullScreenButtonRightMargin;
    self.trafficLightLeftMargin.doubleValue = self.window.trafficLightButtonsLeftMargin;
    
    [self setupCloseButton];
    [self setupMinimizeButton];
    [self setupZoomButton];
}

- (void)setupCloseButton {
    INWindowButton *closeButton = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    closeButton.target = self.window;
    closeButton.action = @selector(performClose:);
    closeButton.activeImage = [NSImage imageNamed:@"close-active-color.tiff"];
    closeButton.activeNotKeyWindowImage = [NSImage imageNamed:@"close-activenokey-color.tiff"];
    closeButton.inactiveImage = [NSImage imageNamed:@"close-inactive-disabled-color.tiff"];
    closeButton.pressedImage = [NSImage imageNamed:@"close-pd-color.tiff"];
    closeButton.rolloverImage = [NSImage imageNamed:@"close-rollover-color.tiff"];
    self.window.closeButton = closeButton;
}

- (void)setupMinimizeButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.target = self.window;
    button.action = @selector(performMiniaturize:);
    button.activeImage = [NSImage imageNamed:@"minimize-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"minimize-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"minimize-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"minimize-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"minimize-rollover-color.tiff"];
    self.window.minimizeButton = button;
}

- (void)setupZoomButton {
    INWindowButton *button = [INWindowButton windowButtonWithSize:NSMakeSize(14, 16) groupIdentifier:nil];
    button.target = self.window;
    button.action = @selector(performZoom:);
    button.activeImage = [NSImage imageNamed:@"zoom-active-color.tiff"];
    button.activeNotKeyWindowImage = [NSImage imageNamed:@"zoom-activenokey-color.tiff"];
    button.inactiveImage = [NSImage imageNamed:@"zoom-inactive-disabled-color.tiff"];
    button.pressedImage = [NSImage imageNamed:@"zoom-pd-color.tiff"];
    button.rolloverImage = [NSImage imageNamed:@"zoom-rollover-color.tiff"];
    self.window.zoomButton = button;
}

- (IBAction)showSheetAction:(id)sender
{
    [NSApp beginSheet:self.sheet modalForWindow:self.window
        modalDelegate:self didEndSelector:nil contextInfo:nil];
}

- (IBAction)doneSheetAction:(id)sender
{
    [self.sheet orderOut:nil];
    [NSApp endSheet:self.sheet];
}

- (IBAction)createWindowController:(id)sender
{
    SampleWindowController *controller = [[SampleWindowController alloc] initWithWindowNibName:@"SampleWindow"];
    [controller showWindow:nil];
    [self.windowControllers addObject:controller];
    [controller release];
}

- (IBAction)checkboxAction:(id)sender
{
    if ( [sender isEqual:self.centerFullScreen] ) {
        self.window.centerFullScreenButton = [sender state];
    } else if ( [sender isEqual:self.centerTrafficLight] ) {
        self.window.centerTrafficLightButtons = [sender state];
    } else if ( [sender isEqual:self.verticalTrafficLight] ) {
        self.window.verticalTrafficLightButtons = [sender state];
    } else {
        self.window.showsBaselineSeparator = [sender state];
    }
}

- (IBAction)sliderAction:(id)sender 
{
    if ( [sender isEqual:self.fullScreenRightMarginSlider] ) {
        self.window.fullScreenButtonRightMargin = [sender doubleValue];
    } else {
        self.window.trafficLightButtonsLeftMargin = [sender doubleValue];
    }    
}

- (void)dealloc
{
    [_windowControllers release];
    [super dealloc];
}
@end
