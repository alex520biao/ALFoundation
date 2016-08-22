//
//  ALViewController.h
//  ALFoundation
//
//  Created by alex520biao on 08/01/2016.
//  Copyright (c) 2016 alex520biao. All rights reserved.
//

@import UIKit;
#import <ALFoundation/GCDMulticastDelegate.h>

@protocol MyDelegate

@optional

-(void)test;

@end

@interface ALViewController : UIViewController

@property (nonatomic,strong) GCDMulticastDelegate<MyDelegate> *multiDelegate;

@end
