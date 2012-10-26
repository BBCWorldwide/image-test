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

static NSString *CellIdentifier = @"Cell";

@interface ITTableViewController ()

@property (nonatomic,retain) NSArray *thumbnails;

@end

@implementation ITTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[ITTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    self.tableView.rowHeight = 54;
    
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

}

@end
