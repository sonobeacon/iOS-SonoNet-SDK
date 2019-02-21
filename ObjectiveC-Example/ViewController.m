#import "ViewController.h"

@import sonolib;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SonoSystem *sonoSystem = [SonoSystem shared];
    SonoSystemCredentials *credentials = [[SonoSystemCredentials alloc] initWithApiKey:@"YOUR_API_KEY" locationId:"YOUR_LOCATION_ID"];
    [sonoSystem bindWithCredentials:(credentials) andOptionalContentView:nil];
    
    [sonoSystem setWhenBluetoothDisabled:^{
        // do nothing so far
    }];
    
    
    [sonoSystem setDidReceiveContent:^(id webLink) {
        NSString *title = [webLink title];
        NSLog(@"%@", title);
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
