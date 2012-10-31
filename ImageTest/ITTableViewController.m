//
//  ITTableViewController.m
//  ImageTest
//
//  Created by Nick Lupinetti on 10/24/12.
//  Copyright (c) 2012 BBCWorldwide. All rights reserved.
//

#import "ITTableViewController.h"
#import "ITImageGetter.h"
#import "ITTableViewCell.h"
#import "ITPageViewController.h"
#import "PhotoViewController.h"

static NSString *CellIdentifier = @"Cell";

@interface ITTableViewController ()

@property (nonatomic,retain) NSArray *thumbnails;

@end

@implementation ITTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.tableView.rowHeight = 54;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.tableView.rowHeight *= 2;
    }
    
    self.thumbnails = [[ITImageGetter sharedImageGetter] imagesForCurrentDeviceOfSize:ITImageSizeThumb];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.thumbnails.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.imageView.backgroundColor = [UIColor blackColor];
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.image = self.thumbnails[indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoViewController *initialPage = [PhotoViewController photoViewControllerForPageIndex:indexPath.row];
    
    UIPageViewController *pager = [[ITPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey : @12, UIPageViewControllerOptionSpineLocationKey : @(UIPageViewControllerSpineLocationNone)}];
    
    pager.dataSource = self;
    pager.view.backgroundColor = [UIColor blackColor];
    
    [pager setViewControllers:@[initialPage] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self.navigationController pushViewController:pager animated:YES];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerBeforeViewController:(PhotoViewController *)vc {
    NSUInteger index = vc.pageIndex;
    return [PhotoViewController photoViewControllerForPageIndex:(index - 1)];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pvc viewControllerAfterViewController:(PhotoViewController *)vc {
    NSUInteger index = vc.pageIndex;
    return [PhotoViewController photoViewControllerForPageIndex:(index + 1)];
}

@end
