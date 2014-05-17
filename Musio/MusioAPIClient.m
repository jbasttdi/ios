//
//  MusioAPIClient.m
//  Musio
//
//  Created by Oli Young on 9/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioAPIClient.h"
//NSString * const kMusioBaseURLString = @"http://api.musio.co";
NSString * const kMusioBaseURLString = @"http://localhost:5100";

@implementation MusioAPIClient

+ (MusioAPIClient *)sharedClient {
    static MusioAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kMusioBaseURLString]];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}

- (void)signUp:(NSString *)email
  withPassword:(NSString *)password
       andName:(NSString *)name
       success:(void (^)(NSURLSessionDataTask *, id))success
       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {

    [self POST:@"api/v1/users"
    parameters:@{@"user": @{@"email": email, @"name": name, @"password": password}}
       success:^(NSURLSessionDataTask *task, id responseObject) {
           if (success) {
               success(task, responseObject);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           if (failure) {
               failure(task, error);
           }
       }];
}

- (void)signIn:(NSString *)email
  withPassword:(NSString *)password
       success:(void (^)(NSURLSessionDataTask *, id))success
       failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {

    [self POST:@"api/v1/sessions"
    parameters:@{@"user": @{@"email": email, @"password": password}}
       success:^(NSURLSessionDataTask *task, id responseObject) {
           if (success) {
               success(task, responseObject);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           if (failure) {
               failure(task, error);
           }
       }];
}


- (void)postAPNToken:(NSString *)device_token
                  to:(NSString *)user_uuid
             success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSString* path = [NSString stringWithFormat:@"api/v1/users/%@.json", user_uuid];
    NSString* device = [NSString stringWithFormat:@"%@",  [[UIDevice currentDevice] model]];

    if (device_token != NULL) {
        [self PATCH:path
         parameters:@{@"token": [Lockbox stringForKey:@"token"], @"user": @{@"device_token":device_token, @"device_kind": device }}
            success:^(NSURLSessionDataTask *task, id responseObject) {
                if (success) {
                    success(task, responseObject);
                }
            }
            failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failure) {
                    failure(task, error);
                }
            }];
    }
}

- (void)getInbox:(NSString *)user_uuid
         success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSString* path =  @"api/v1/inbox.json";
    
    [self GET:path
   parameters:@{@"token": [Lockbox stringForKey:@"token"]}
      success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

@end
