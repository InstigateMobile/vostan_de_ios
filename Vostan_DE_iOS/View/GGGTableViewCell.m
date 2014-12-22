//
//  VGraph.h
//  Vostan_Native_iOS
//
//  Copyright (c) 2014. All rights reserved.
//

#import "GGGTableViewCell.h"

int const GGGTableViewCellWidth = 310;
int const GGGTableViewCellHeight = 35;


@interface GGGTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UIImageView *icon;

@end

@implementation GGGTableViewCell

+ (NSString *)reuseIdentifier {
  return @"GGGTableViewCell";
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    [_label setFont:[UIFont fontWithName:selected ? @"HelveticaNeue-Bold" : @"Helvetica Neue" size:15]];
    [_icon setHidden:!selected];
}

- (void)setDomain:(NSString *)domain {
  [_label setText:domain];
}

@end
