//
//  VModelHandler.m
//  Vostan_DE_iOS
//
//  This file is part of Vostan framework.
//  Vostan is an open-source Information Management Platform that can be used to
//  build GGG (web 3.0) web-sites and presentations using mind-map based
//  human-machine-interaction paradigm and information management.
//  Project home page [http://ggg.vostan.net]
//  Copyright (c) 2011-2014 Instigate Mobile cjsc, [http://ggg.instigatemobile.com]
//  Vostan is a free software: you can redistribute it and/or modify it under the
//  terms of the GNU Affero General Public License as published by the Free
//  Software Foundation, either version 3 of the License, or (at your option) any
//  later version.
//  This program is distributed in the hope that it will be useful, but WITHOUT ANY
//  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
//  PARTICULAR PURPOSE. See the GNU Affero General Public License for more
//  details.
//  You should have received a copy of the GNU Affero General Public License
//  along with this program. If not, see [http://www.gnu.org/licenses/].
//

#import "VModelHandler.h"
#import "VGraph.h"
#import "AFHTTPRequestOperationManager.h"

@interface VModelHandler ()
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;
@property (nonatomic, strong) NSDictionary *gggDict;
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
    
    _tempCache = [@{} mutableCopy];
    
    _gggDict = @{@"ggg.vostan.net" : @"lang/en",
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

- (NSArray *)gggList {
  return [NSArray arrayWithArray:[_gggDict allKeys]];
}

#pragma  mark -
- (NSString *)getFormatedRequestStringForDomain:(NSString *)domain andRootID:(NSUInteger)rootID {
  return [NSString stringWithFormat:@"http://%@/api.php/map/root/%i/%@", domain, (int)rootID, [_gggDict objectForKey:domain]];
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
