//
//  VNode.h
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

#import "VNode.h"

@implementation VNode

- (id)initWithDictionary:(NSDictionary *)dict domain:(NSString *)domain
{
  self = [super init];
  if (self) {
    self.nodeID = [[dict objectForKey:@"nodeID"] integerValue];
    self.nodeRect = CGRectMake([[dict objectForKey:@"left"] floatValue],
                               [[dict objectForKey:@"top"] floatValue],
                               [[dict objectForKey:@"width"] floatValue],
                               [[dict objectForKey:@"height"] floatValue]);
    
    self.isLeaf = [[dict objectForKey:@"leaf"] boolValue];
    self.isCarousel = [[dict objectForKey:@"carousel"] boolValue];
    
    self.script = [dict objectForKey:@"script"];
    self.tags = [dict objectForKey:@"tags"];
    self.users = [dict objectForKey:@"users"];
    self.user = [dict objectForKey:@"user"];
    self.viewers = [dict objectForKey:@"viewers"]; //all
    
    self.defaultTags = [dict objectForKey:@"defaultTags"];
    self.defaultTitle = [dict objectForKey:@"defaultTitle"];
    self.defaultBody = [dict objectForKey:@"defaultTxt"];
    
    self.title = [dict objectForKey:@"title"];
    self.titleVisible = [[dict objectForKey:@"titleInclude"] boolValue];
    self.titleRect = CGRectMake([[dict objectForKey:@"titleLeft"] floatValue],
                                [[dict objectForKey:@"titleTop"] floatValue],
                                [[dict objectForKey:@"titleWidth"] floatValue],
                                [[dict objectForKey:@"titleHeight"] floatValue]);
    
    self.body = [dict objectForKey:@"txt"];
    self.bodyVisible = [[dict objectForKey:@"txtInclude"] boolValue];
    self.bodyRect = CGRectMake([[dict objectForKey:@"txtLeft"] floatValue],
                               [[dict objectForKey:@"txtTop"] floatValue],
                               [[dict objectForKey:@"txtWidth"] floatValue],
                               [[dict objectForKey:@"txtHeight"] floatValue]);
    
    self.imageUrl = [dict objectForKey:@"img"];
    self.imageVisible = [[dict objectForKey:@"imgInclude"] boolValue];
    self.imageRect = CGRectMake([[dict objectForKey:@"imgLeft"] floatValue],
                                [[dict objectForKey:@"imgTop"] floatValue],
                                [[dict objectForKey:@"imgWidth"] floatValue],
                                [[dict objectForKey:@"imgHeight"] floatValue]);
    
    self.domain = domain;
  }
  
  return self;
}


@end
