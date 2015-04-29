//
//  KSViewController.m
//  NSURLSession_KSSampleCode
//
//  Created by Debasis Das on 4/19/15.
//  Copyright (c) 2015 Knowstack. All rights reserved.
//

#import "KSViewController.h"
#import "KSService.h"
#import "KSConstants.h"
//static NSString *dataURLString = @"http://www.knowstack.com/DemoData/EmployeeRecords.json";

@interface KSViewController ()

@property (weak, nonatomic) IBOutlet NSProgressIndicator *progressIndicator;
@property (weak, nonatomic) IBOutlet NSTextField *progressIndicatorLabel;
@property (weak, nonatomic) IBOutlet NSTextField *dataURLTextField;
@property (assign) IBOutlet NSTextView *responseDataTextView;

@property (nonatomic,strong) NSURLSession *session;
@property (nonatomic,strong) NSURLSessionDataTask *finderTask;
@end

@implementation KSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideProgressIndicator];
    [self.dataURLTextField setStringValue:EMPLOYEE_DATA_URL];


}



-(IBAction)findDataFromWebService:(id)sender
{
    [self.responseDataTextView setString:@""];
    [self showProgressIndicator];
    [[KSService sharedInstance] fetchEmployeeDataWithCompletionBlock:^(NSArray *employeeArray, NSError *error) {
        if (!error) {
            NSLog(@"employeeArray %@",employeeArray);
            
            [self.responseDataTextView setString:[employeeArray description]];
            [self hideProgressIndicator];
        }
        else
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [NSApp presentError:error];
            }];
        }
    }];
}



#pragma mark Find Using NSURLSession Delegate Approach
- (NSURLSession *)createSession
{
    static NSURLSession *session = nil;
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                            delegate:self
                                       delegateQueue:[NSOperationQueue mainQueue]];
    return session;
}


-(IBAction)findDataUsingDelegate:(id)sender{
    [self.responseDataTextView setString:@""];
    [self showProgressIndicator];
    self.session = [self createSession];
    
    NSURL *dataURL = [NSURL URLWithString:EMPLOYEE_DATA_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:dataURL];
    self.finderTask = [self.session dataTaskWithRequest:request];
    [self.finderTask resume];
}


- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self.responseDataTextView setString:[dataArray description]];
    [self hideProgressIndicator];

}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse *cachedResponse))completionHandler{
     NSLog(@"%s",__func__);
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error{
     NSLog(@"%s",__func__);
}

#pragma mark Progress Indicator
-(void)showProgressIndicator{
    [self.progressIndicator setHidden:NO];
    [self.progressIndicatorLabel setHidden:NO];
    [self.progressIndicator startAnimation:self];

}

-(void)hideProgressIndicator{
    [self.progressIndicator setHidden:YES];
    [self.progressIndicatorLabel setHidden:YES];
    [self.progressIndicator stopAnimation:self];

}
@end
