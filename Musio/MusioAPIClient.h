//
//  MusioAPIClient.h
//  Musio
//
//  Created by Oli Young on 9/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

extern NSString * const kMusioBaseURLString;

@interface MusioAPIClient : AFHTTPSessionManager
    + (MusioAPIClient *)sharedClient;

- (void)getInbox:(NSString *)user_uuid
        success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)postAPNToken:(NSString *)token
                  to:(NSString *)user_uuid
             success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
