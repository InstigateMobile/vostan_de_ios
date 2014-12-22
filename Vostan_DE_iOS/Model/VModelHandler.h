//
//  VModelHandler.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "VGraph.h"

@protocol VModelHandlerDelegate <NSObject>


@end

@interface VModelHandler : NSObject

@property (nonatomic, weak) id <VModelHandlerDelegate> delegate;

@property NSMutableArray *nodes;
@property NSMutableArray *links;

+ (VModelHandler *)instance;

- (void)requestGraphWithRoot:(int)root fromGGG:(NSString *)ggg completion:(void (^)(VGraph *))block;


@end