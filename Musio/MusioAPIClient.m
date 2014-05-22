//
//  MusioAPIClient.m
//  Musio
//
//  Created by Oli Young on 9/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioAPIClient.h"
#if TARGET_CPU_ARM
NSString * const kMusioBaseURLString = @"http://api.musio.co";
#else
NSString * const kMusioBaseURLString = @"http://192.168.1.9:5100";
#endif

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

- (void)signOut:(NSString *)email
      withToken:(NSString *)token
        success:(void (^)(NSURLSessionDataTask *, id))success
        failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    [Lockbox setString:nil forKey:@"token"];
    [Lockbox setString:nil forKey:@"email"];
    [Lockbox setString:nil forKey:@"password"];
    [Lockbox setString:nil forKey:@"uuid"];
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

    if (device_token != NULL
        && [Lockbox stringForKey:@"token"] != nil
        && [Lockbox stringForKey:@"uuid"] != nil) {
        NSString* path = [NSString stringWithFormat:@"api/v1/users/%@.json", [Lockbox stringForKey:@"uuid"]];
        NSString* device = [NSString stringWithFormat:@"%@",  [[UIDevice currentDevice] model]];

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

- (void)getTracksWithSuccess:(void(^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString* path =  @"api/v1/uploads.json";
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
