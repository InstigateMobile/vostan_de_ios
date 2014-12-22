//
//  VNode.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
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
