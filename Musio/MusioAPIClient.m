//
//  MusioAPIClient.m
//  Musio
//
//  Created by Oli Young on 9/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import "MusioAPIClient.h"
NSString * const kMusioBaseURLString = @"http://api.musio.co";

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

- (void)postAPNToken:(NSString *)token
                  to:(NSString *)user_uuid
             success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
             failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    
    [self PATCH:path parameters:@{@"apntoken":token} success:^(NSURLSessionDataTask *task, id responseObject) {
    NSString* path = [NSString stringWithFormat:@"api/v1/users/%@.json", user_uuid];
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

- (void)getInbox:(NSString *)user_uuid
         success:(void(^)(NSURLSessionDataTask *task, id responseObject))success
         failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSString* path =  @"api/v1/inbox.json";
    
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

@end
