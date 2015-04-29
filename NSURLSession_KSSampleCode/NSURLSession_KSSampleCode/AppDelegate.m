//
//  AppDelegate.m
//  NSURLSession_KSSampleCode
//
//  Created by Debasis Das on 4/19/15.
//  Copyright (c) 2015 Knowstack. All rights reserved.
//

#import "AppDelegate.h"
#import "KSWindowController.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property(atomic, strong) NSMutableArray  *windowControllers;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    _windowControllers = [NSMutableArray new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(windowWillCloseNotification:)
                                                 name:NSWindowWillCloseNotification
                                               object:nil];
    
    [self showEmployeeFinder:self];

}

- (void)windowWillCloseNotification:(NSNotification*)notification
{
    NSWindow *closingWindow = [notification object];
    NSWindowController *closingWindowController = [closingWindow windowController];
    
    if (closingWindowController)
    {
        NSUInteger index = [[self windowControllers] indexOfObjectIdenticalTo:closingWindowController];
        
        if (index != NSNotFound)
        {
            ([[self windowControllers] removeObjectAtIndex:index]);
        }
    }
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(IBAction)showEmployeeFinder:(id)sender{
    KSWindowController *kwc = [[KSWindowController alloc] init];
    [kwc showWindow:self];
    [self.windowControllers addObject:kwc];
    NSLog(@"self.windowControllers %@",self.windowControllers);
}

@end
