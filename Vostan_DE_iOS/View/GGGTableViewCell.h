//
//  VGraph.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import <UIKit/UIKit.h>

extern int const GGGTableViewCellWidth;
extern int const GGGTableViewCellHeight;

@interface GGGTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;

- (void)setDomain:(NSString *)domain;

@end

