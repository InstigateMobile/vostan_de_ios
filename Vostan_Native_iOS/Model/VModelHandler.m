//
//  VModelHandler.m
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "VModelHandler.h"
#import "VGraph.h"
#import "AFHTTPRequestOperationManager.h"

@interface VModelHandler ()
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;
@property (nonatomic, strong) NSMutableDictionary *tempCache;

@end

@implementation VModelHandler

static VModelHandler *instance = nil;

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
    
//    [[AFHTTPRequestOperationManager manager] setSecurityPolicy:_securityPolicy];
  }
  return self;
}

#pragma  mark -
- (NSString *)getFormatedRequestStringForDomain:(NSString *)domain andRootID:(NSUInteger)rootID {
  return [NSString stringWithFormat:@"http://%@/api.php/map/root/%i/lang/hy", domain, (int)rootID];
}

#pragma  mark -
- (void)requestGraphWithRoot:(int)root fromGGG:(NSString *)ggg completion:(void (^)(VGraph *))block {
  NSString *string = [self getFormatedRequestStringForDomain:ggg andRootID:root];
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
    if (jsonDict) {
      VGraph *graph = [[VGraph alloc] initWithDictionary:jsonDict];
      block(graph);
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error.description);
  }];
  
  operation.securityPolicy = _securityPolicy;
  [operation start];
}

@end
