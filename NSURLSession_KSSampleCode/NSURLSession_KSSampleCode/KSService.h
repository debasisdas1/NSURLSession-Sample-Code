//
//  KSService.h
//  NSURLSession_KSSampleCode
//
//  Created by Debasis Das on 4/19/15.
//  Copyright (c) 2015 Knowstack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSService : NSObject

+(KSService *)sharedInstance;

-(void) fetchEmployeeDataWithCompletionBlock:(void(^)(NSArray *employeeArray, NSError *error)) completionBlock;

@end
