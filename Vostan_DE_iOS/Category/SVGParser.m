//
//  SVGParser.m
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

#import "SVGParser.h"
#import "PocketSVG.h"

@implementation UIImage (SVGParser)

+ (UIImage *)imageWithSize:(CGSize)size andSVGData:(NSData *)data {
  UIImage *image = [[UIImage alloc] init];
  
  @try {
    PocketSVG *rawSVG = [[PocketSVG alloc] initFromSVGData:data];
    CGSize x = CGSizeMake(rawSVG.width,rawSVG.height);
    
//    CGFloat scaleFactor = 1 / MAX(rawSVG.height / size.height, rawSVG.width / size.width);
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformScale(transform, scaleFactor, scaleFactor);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    
    for (UIBezierPath *path in rawSVG.beziers) {
      CGPathRef scaledPath = [path CGPath];//CGPathCreateCopyByTransformingPath([path CGPath], &transform);
      CGContextAddPath(context, scaledPath);
    }
    
    CGContextFillPath(context);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

  } @catch (NSException *exception) {}
  
  return image;
}

@end
