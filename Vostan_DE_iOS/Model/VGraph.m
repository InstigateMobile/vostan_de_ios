//
//  VGraph.m
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

#import "VGraph.h"
#import "VNode.h"
#import "VLink.h"

@implementation VGraph

- (id)initWithDictionary:(NSDictionary *)dict andDomain:(NSString *)domain
{
  self = [super init];
  if (self) {
    NSArray *nodeDictArray = [dict objectForKey:@"nodes"];
    NSArray *linkDictArray = [dict objectForKey:@"links"];
    
    NSMutableArray *nodes = [@[] mutableCopy];
    NSMutableArray *links = [@[] mutableCopy];
    
    for (NSDictionary *nodeDict in nodeDictArray) {
      [nodes addObject:[[VNode alloc] initWithDictionary:nodeDict domain:domain]];
    }
    for (NSDictionary *linkDict in linkDictArray) {
      [links addObject:[[VLink alloc] initWithDictionary:linkDict]];
    }
    
    _nodes = [NSArray arrayWithArray:nodes];
    _links = [NSArray arrayWithArray:links];
    _rootID = [[dict objectForKey:@"root"] unsignedIntegerValue];
    _domain = domain;

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
