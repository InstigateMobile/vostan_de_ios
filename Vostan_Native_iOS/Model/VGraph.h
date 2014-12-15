//
//  VGraph.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

@class VNode;

@interface VGraph : NSObject

@property NSString *domain;
@property NSUInteger rootID;
@property NSArray *nodes;
@property NSArray *links;

- (id)initWithDictionary:(NSDictionary *)dictionary andDomain:(NSString *)domain;
- (VNode *)nodeWithID:(NSUInteger)nodeID;

@end
