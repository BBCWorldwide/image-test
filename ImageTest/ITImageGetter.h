//
//  ITImageGetter.h
//  ImageTest
//
//  Created by Nick Lupinetti on 10/24/12.
//  Copyright (c) 2012 BBCWorldwide. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ITImageSizeThumb,
    ITImageSizeGrid,
    ITImageSizeFull
}ITImageSize;

@interface ITImageGetter : NSObject

+ (id)sharedImageGetter;
- (NSUInteger)numberOfImages;
- (NSArray*)imagesForCurrentDeviceOfSize:(ITImageSize)size;
- (UIImage*)imageForCurrentDeviceOfSize:(ITImageSize)size atIndex:(NSUInteger)index;

@end
