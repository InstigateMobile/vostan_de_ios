//
//  VModelHandler.m
//  Vostan_Native_iOS
//
//  Created by Macadamian User on 12/13/14.
//  Copyright (c) 2014 AUA. All rights reserved.
//

#import "VModelHandler.h"
#import "VNode.h"
#import "AFHTTPRequestOperationManager.h"

@interface VModelHandler ()
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;

@end

@implementation VModelHandler

static VModelHandler *instance = nil;

// Get the shared instance and create it if necessary.
+ (VModelHandler *)instance
{
  if (instance == nil) {
    instance = [[self alloc] init];
  }
  return instance;
}

- (id)init
{
  self = [super init];
  if (self) {
    _securityPolicy = [[AFSecurityPolicy alloc] init];
    [_securityPolicy setAllowInvalidCertificates:YES];
  }
  return self;
}

#pragma  mark - 

- (void)testConnectToVostan {
//  NSString *urlString = [NSString stringWithFormat:@"https://edu.vostan.net/erp/vostan_DE_iOS_native_app/api.php/map/root/5/lang/en"];
  NSString *urlString = [NSString stringWithFormat:@"http://ggg.instigate-training-center.am/api.php/map/root/1/lang/hy"];
  
  NSURL *URL = [NSURL URLWithString:urlString];
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];
  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
    NSArray *nodes = [jsonDict objectForKey:@"nodes"];
    NSArray *links = [jsonDict objectForKey:@"links"];
    
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error.description);
  }];

  operation.securityPolicy = _securityPolicy;
  [operation start];
}


@end
