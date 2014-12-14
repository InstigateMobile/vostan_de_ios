//
//  VGraph.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

@class VNode;

@interface VGraph : NSObject

@property NSUInteger rootID;
@property NSArray *nodes;
@property NSArray *links;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (VNode *)nodeWithID:(NSUInteger)nodeID;

@end
