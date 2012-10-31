//
//  ITPageViewController.m
//  ImageTest
//
//  Created by Nick Lupinetti on 10/31/12.
//  Copyright (c) 2012 BBCWorldwide. All rights reserved.
//

#import "ITPageViewController.h"

@interface ITPageViewController ()

- (void)handleTap:(UITapGestureRecognizer*)tap;

@end

@implementation ITPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}

@end
