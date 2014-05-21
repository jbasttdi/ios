//
//  MusioUploadViewController.h
//  Musio
//
//  Created by Oli Young on 16/05/2014.
//  Copyright (c) 2014 Musio Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusioUploadViewController : UIViewController
@property (strong, nonatomic) NSMutableDictionary* track;

- (void)share:(id)sender;
- (void)playTouch:(id)sender;

@end
