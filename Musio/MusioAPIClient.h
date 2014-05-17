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

- (void)signIn:(NSString *)email
  withPassword:(NSString *)password
       success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
       failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)signUp:(NSString *)email
  withPassword:(NSString *)password
       andName:(NSString *)name
       success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
       failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)signOut:(NSString *)email
      withToken:(NSString *)token
           success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
           failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)getInbox:(NSString *)user_uuid
        success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

- (void)postAPNToken:(NSString *)device_token
                  to:(NSString *)user_uuid
             success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
