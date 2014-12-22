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
