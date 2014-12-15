//
//  VNode.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

@interface VNode : NSObject

@property NSUInteger nodeID;
@property CGRect nodeRect;

@property BOOL isLeaf;
@property BOOL isCarousel;

@property NSString *tags;
@property NSString *users;
@property NSString *user;
@property NSString *viewers;
@property NSString *script;

@property NSString *defaultTags;
@property NSString *defaultTitle;
@property NSString *defaultBody;

@property NSString *title;
@property CGRect titleRect;
@property BOOL titleVisible;

@property NSString *body;   // ex. "<p><br data-mce-bogus=\"1\"></p>"
@property CGRect bodyRect;
@property BOOL bodyVisible;

@property NSString *imageUrl;  // ex.
@property CGRect imageRect;
@property BOOL imageVisible;

@property NSString *domain;


- (id)initWithDictionary:(NSDictionary *)dictionary domain:(NSString *)domain;


@end
