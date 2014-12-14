//
//  VGraph.m
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "VGraph.h"
#import "VNode.h"
#import "VLink.h"

@implementation VGraph

- (id)initWithDictionary:(NSDictionary *)dict
{
  self = [super init];
  if (self) {
    NSArray *nodeDictArray = [dict objectForKey:@"nodes"];
    NSArray *linkDictArray = [dict objectForKey:@"links"];
    
    NSMutableArray *nodes = [@[] mutableCopy];
    NSMutableArray *links = [@[] mutableCopy];
    
    for (NSDictionary *nodeDict in nodeDictArray) {
      [nodes addObject:[[VNode alloc] initWithDictionary:nodeDict]];
    }
    for (NSDictionary *linkDict in linkDictArray) {
      [links addObject:[[VLink alloc] initWithDictionary:linkDict]];
    }
    
    _nodes = [NSArray arrayWithArray:nodes];
    _links = [NSArray arrayWithArray:links];
    _rootID = [[dict objectForKey:@"root"] unsignedIntegerValue];

  }
  return self;
}

- (VNode *)nodeWithID:(NSUInteger)nodeID {
  for (id object in _nodes) {
    if ([(VNode *)object nodeID] == nodeID) {
      return object;
    }
  }
  return nil;
}

@end
