//
//  VTitleLabel.m
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "VTitleLabel.h"

@implementation UILabel (VTitleLabel)

- (void)sizeToFitFixedWidth:(CGFloat)fixedWidth
{
  self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, 0);
  self.lineBreakMode = NSLineBreakByWordWrapping;
  self.numberOfLines = 0;
  [self sizeToFit];
}

@end
