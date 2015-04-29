//
//  KSService.m
//  NSURLSession_KSSampleCode
//
//  Created by Debasis Das on 4/19/15.
//  Copyright (c) 2015 Knowstack. All rights reserved.
//

#import "KSService.h"
#import "KSConstants.h"



@implementation KSService


+(KSService *) sharedInstance
{
    static KSService *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[KSService alloc] init];
    });
    
    return _sharedInstance;
}

-(void) fetchEmployeeDataWithCompletionBlock:(void(^)(NSArray *employeeArray, NSError *error)) completionBlock;
{
     NSLog(@"main thread? ANS - %@",[NSThread isMainThread]? @"YES":@"NO");
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSString *cachePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"/nsurlsessiondemo.cache"];

    NSURLCache *myCache = [[NSURLCache alloc] initWithMemoryCapacity: 16384
                                                        diskCapacity: 268435456
                                                            diskPath: cachePath];
    defaultConfigObject.URLCache = myCache;
    
    defaultConfigObject.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                      delegate: nil
                                                                 delegateQueue: [NSOperationQueue mainQueue]];
    
    
    NSURL *dataURL = [NSURL URLWithString:EMPLOYEE_DATA_URL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:dataURL];
    
    [[delegateFreeSession dataTaskWithRequest:request
                            completionHandler:^(NSData *data, NSURLResponse *response,
                                                NSError *error)
                            {
                                NSLog(@"Got response %@ with error %@.\n", response, error);
                                NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                completionBlock (dataArray, error);
                            }
      ]resume];
}

@end
