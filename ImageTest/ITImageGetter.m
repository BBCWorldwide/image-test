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
static NSNumberFormatter *twoDigit;
static NSOperationQueue *backgroundQueue;

@implementation ITImageGetter

+ (void)initialize {
    twoDigit = [[NSNumberFormatter alloc] init];
    twoDigit.formatWidth = 2;
    twoDigit.paddingCharacter = @"0";
    
    backgroundQueue = [[NSOperationQueue alloc] init];
}

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

- (NSUInteger)numberOfImages {
    return 4;
}

- (NSArray*)imagesForCurrentDeviceOfSize:(ITImageSize)size {
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[self numberOfImages]];
    
    for (int i = 0; i < [self numberOfImages]; i++) {
        [images addObject:[self imageForCurrentDeviceOfSize:size atIndex:i]];
    }
    
    return images.copy;
}

- (UIImage*)imageForCurrentDeviceOfSize:(ITImageSize)size atIndex:(NSUInteger)index {
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
    
    NSNumber *indexNumber = [NSNumber numberWithInt:index + 1];
    NSString *indexString = [twoDigit stringFromNumber:indexNumber];
    NSString *imageName = [NSString stringWithFormat:@"%@-%@-%@%@",deviceName,imageType,indexString,screenRes];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imagePath] scale:1.0];
    return image;
}

@end
