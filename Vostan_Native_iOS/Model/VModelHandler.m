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
@property (nonatomic, strong) NSDictionary *languageDict;
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
    
    _languageDict = @{@"ggg.vostan.net" : @"lang/en",
                      @"ggg.instigate.am" : @"lang/en",
                      @"ggg.instigatemobile.com" : @"lang/en",
                      @"ggg.instigate-training-center.am": @"lang/hy",
                      @"ggg.instigateconsulting.com": @"lang/en",
                      @"ggg.i-gorc.am": @"lng/hy",
                      @"ggg.instigaterobotics.com": @"lang/en",
                      @"ggg.improve.am": @"lang/en",
                      @"ggg.yerevak.com": @"lang/en",
                      @"ggg.proximusda.com": @"lang/en",
                      @"ggg.tri.am": @"lang/en"};
  }
  return self;
}

#pragma  mark -
- (NSString *)getFormatedRequestStringForDomain:(NSString *)domain andRootID:(NSUInteger)rootID {
  return [NSString stringWithFormat:@"http://%@/api.php/map/root/%i/%@", domain, (int)rootID, [_languageDict objectForKey:domain]];
}

#pragma  mark -
- (void)requestGraphWithRoot:(int)root fromGGG:(NSString *)ggg completion:(void (^)(VGraph *))block {
  NSString *string = [self getFormatedRequestStringForDomain:ggg andRootID:root];
  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:string]];
  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
    if (jsonDict) {
      VGraph *graph = [[VGraph alloc] initWithDictionary:jsonDict andDomain:ggg];
      [graph setDomain:ggg];
      block(graph);
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error.description);
  }];
  
  operation.securityPolicy = _securityPolicy;
  [operation start];
}

@end
