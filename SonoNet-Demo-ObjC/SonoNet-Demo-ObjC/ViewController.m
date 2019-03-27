//
//  ViewController.m
//  SonoNet-Demo-ObjC
//
//  Created by Sascha Melcher on 26.03.19.
//  Copyright © 2019 SonoBeacon. All rights reserved.
//

#import "ViewController.h"

@import sonolib;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet ContentView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SonoNet *sonoNet = [SonoNet shared];
    SonoNetCredentials *credentials = [[SonoNetCredentials alloc] initWithApiKey:@"YOUR_API_KEY" locationId:@"LOCATION_ID"];
    [sonoNet bindWithCredentials:(credentials) andOptionalContentView:contentView];
    
    [sonoNet setWhenBluetoothDisabled:^{
        // TODO -show alert
    }];
    
    
    [sonoNet setDidReceiveContent:^(id webLink) {
        __weak ViewController *wSelf = self;
        NSString *title = [webLink title];
        NSLog(@"Title", title);
    }];

}


@end
