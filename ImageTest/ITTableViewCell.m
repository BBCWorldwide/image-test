//
//  ITTableViewCell.m
//  ImageTest
//
//  Created by Nick Lupinetti on 10/24/12.
//  Copyright (c) 2012 BBCWorldwide. All rights reserved.
//

#import "ITTableViewCell.h"

@implementation ITTableViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, 72, 54);
}

@end
