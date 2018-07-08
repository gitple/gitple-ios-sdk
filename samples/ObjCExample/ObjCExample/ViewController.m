//
//  GitpleViewController.m
//  ObjCExample
//
//  Created by Vincent Woo on 3/02/18.
//  Copyright © 2018 Gitple. All rights reserved.
//

#import "ViewController.h"
#import <GitpleSDK/GitpleSDK-Swift.h>
#import <OneSignal/OneSignal.h>

@interface ViewController () <GitpleDelegate> {
    GitpleViewController* _gitpleViewController;
}

- (IBAction)startChatButton:(id)sender;
- (IBAction)getUnreadCountButton:(id)sender;

@property (nonatomic, retain) GitpleViewController *gitpleViewController;

@end

@implementation ViewController

@synthesize gitpleViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Gitple setDelegate:self];

    // Hide gitple header menu
    (void)[[Gitple config] setHideHeaderWithIsHide:true];
    
    // Set gitple user language
    (void)[[Gitple config] setUserLangWithLang:@"en"];
    
    GitpleUser *gitpleUser = [Gitple user];
    
    (void)[gitpleUser setIdWithId:@"iosobjcuser01"];
    (void)[gitpleUser setEmailWithEmail:@"iosobjcuser01@gitple"];
    (void)[gitpleUser setNameWithName:@"iosobjcuser01"];
    (void)[gitpleUser setPhoneWithPhone:@"0000000000"];
    (void)[gitpleUser setMetaWithKey:@"company" value:@"gitple"];
    (void)[gitpleUser setMetaWithKey:@"order" value:@"gitple"];
    
    // sendTags for OneSignal : {"gp": "userId"}
    [OneSignal sendTags:@{@"gp" : @"iosobjcuser01"} onSuccess:^(NSDictionary *result) {
        NSLog(@"success!");
    } onFailure:^(NSError *error) {
        NSLog(@"Error - %@", error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)startChatButton:(id)sender {
    NSLog(@"startChatButton");
    
    [Gitple launch];
}

- (IBAction)getUnreadCountButton:(id)sender {
    NSLog(@"getUnreadCountButton");
    
    [Gitple unreadCount];
}

- (void)onViewLaunchedWithSender:(GitpleViewController * _Nonnull)sender {
    NSLog(@"onViewLaunchedWithSender");
    
    self.gitpleViewController = sender;
    
    self.gitpleViewController.navigationItem.title = @"Gitple";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                             style:UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(closeGitple:)];
    self.gitpleViewController.navigationItem.rightBarButtonItem = item;
}

- (void)onUnreadCountWithCount:(NSInteger)count {
    NSLog(@"onUnreadCount cunt:%i", (int)count);
    NSString* message = [[NSString alloc] initWithFormat:@"Unread message count: %i", (int)count];
    [self displayAlert:@"Gitple" withMessage:message actions:@[]];
}

- (void)closeGitple:(UIBarButtonItem*)sender {
    NSLog(@"closeGitple");
    
    [[self navigationController] dismissViewControllerAnimated:true completion:nil];
}

- (void)displayAlert:(NSString *)title withMessage:(NSString *)message actions:(NSArray<UIAlertAction *>*)actions {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        if (!actions || actions.count == 0) {
            [controller addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:nil]];
        } else {
            for (UIAlertAction *action in actions) {
                [controller addAction:action];
            }
        }
        [self presentViewController:controller animated:true completion:nil];
    });
}
@end

