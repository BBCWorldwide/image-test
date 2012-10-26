//
//  ITImageGetter.m
//  ImageTest
//
//  Created by Nick Lupinetti on 10/24/12.
//  Copyright (c) 2012 BBCWorldwide. All rights reserved.
//

#import "ITImageGetter.h"
#import "SynthesizeSingleton.h"

static ITImageGetter* imageGetter;

@implementation ITImageGetter

- (id)init {
    if (!imageGetter) {
        imageGetter = [super init];
    }
    
    return imageGetter;
}

+ (id)sharedImageGetter {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageGetter = [[self alloc] init];
    });
    
    return imageGetter;
}

- (id)copyWithZone:(NSZone*)zone {
    return imageGetter;
}

- (NSArray*)imagesForCurrentDeviceOfSize:(ITImageSize)size {
    NSString *deviceName = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? @"iPad" : @"iPhone";
    NSString *screenRes = [[UIScreen mainScreen] scale] == 2.0 ? @"@2x" : @"";
    NSString *imageType = nil;
    switch (size) {
        case ITImageSizeThumb:
            imageType = @"Thumb";
            break;
        case ITImageSizeGrid:
            imageType = @"Grid";
            break;
        case ITImageSizeFull:
            imageType = @"Hero";
            break;
    }
    
    NSNumberFormatter *twoDigit = [[NSNumberFormatter alloc] init];
    twoDigit.formatWidth = 2;
    twoDigit.paddingCharacter = @"0";
    int numberOfImages = 4;
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:numberOfImages];
    
    for (int i = 0; i < numberOfImages; i++) {
        NSNumber *indexNumber = [NSNumber numberWithInt:i+1];
        NSString *index = [twoDigit stringFromNumber:indexNumber];
        NSString *imageName = [NSString stringWithFormat:@"%@-%@-%@%@",deviceName,imageType,index,screenRes];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
        [images addObject:[UIImage imageWithContentsOfFile:imagePath]];
    }
    
    return images.copy;
}

@end
