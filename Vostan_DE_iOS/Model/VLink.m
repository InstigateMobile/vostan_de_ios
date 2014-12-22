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

    self.nodeID = [[dict objectForKey:@"nodeID"] integerValue];
    self.linkedNodeID = [[dict objectForKey:@"linkedNodeID"] integerValue];
    self.linkTags = [dict objectForKey:@"linkTags"];
  }
  
  return self;
}


@end
