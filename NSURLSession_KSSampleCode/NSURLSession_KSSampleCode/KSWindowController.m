//
//  KSWindowController.m
//  NSURLSession_KSSampleCode
//
//  Created by Debasis Das on 4/19/15.
//  Copyright (c) 2015 Knowstack. All rights reserved.
//

#import "KSWindowController.h"

@interface KSWindowController ()
@property (weak) IBOutlet NSView *placeholderView;
@end

@implementation KSWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    [self setViewController:[[KSViewController alloc] init]];
    [[self.viewController view] setFrame:[self.placeholderView frame]];
    [self.placeholderView addSubview:[self.viewController view]];
}

-(NSString *)windowNibName{
    return @"KSWindow";
}
@end
