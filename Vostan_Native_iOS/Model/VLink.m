//
//  VNode.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "VLink.h"

@implementation VLink

- (id)initWithDictionary:(NSDictionary *)dict
{
  self = [super init];
  if (self) {

    self.nodeID = (NSUInteger *)[[dict objectForKey:@"nodeID"] integerValue];
    self.linkedNodeID = (NSUInteger *)[[dict objectForKey:@"linkedNodeID"] integerValue];
    self.linkTags = [dict objectForKey:@"linkTags"];
  }
  
  return self;
}


@end
