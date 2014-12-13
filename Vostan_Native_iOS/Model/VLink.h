//
//  VNode.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

@interface VLink : NSObject

@property NSUInteger *nodeID;
@property NSUInteger *linkedNodeID;
@property NSString *linkTags;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
