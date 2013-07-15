//
//  RDTrendsTableView.m
//  Trendster
//
//  Created by Darshan Katrumane on 5/9/13.
//  Copyright (c) 2013 trendster. All rights reserved.
//

#import "RDTrendsTableView.h"
#import "RDTrendObject.h"

#define CHECKED     1
#define UNCHECKED   2

@interface RDTrendsTableView()  {
    
}
@end

@implementation RDTrendsTableView
@synthesize checkedArray;
@synthesize trendsArray;

-(id) initWithTrends:(NSMutableArray*) trends {
    self = [super init];
    if (self != nil) {
        trendsArray = [trends copy];
        checkedArray = [[NSMutableArray alloc] init];
        [self setDelegate:self];
        [self setDataSource:self];
    }
    return self;
}

-(UIImage *) imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [trendsArray count];
}

-(UIImageView*) imageViewForChecked:(BOOL) checked {
    UIImageView *imageView;
    if (checked) {
        UIImage *image = [UIImage imageNamed:@"checkedIcon.png"];
        imageView = [[UIImageView alloc] initWithImage:[self imageWithImage:image scaledToSize:CGSizeMake(20, 20)]];
        [imageView setTag:CHECKED];
    }else{
        UIImage *image = [UIImage imageNamed:@"uncheckedIcon.png"];
        imageView = [[UIImageView alloc] initWithImage:[self imageWithImage:image scaledToSize:CGSizeMake(20, 20)]];
        [imageView setTag:UNCHECKED];
    }
    return imageView;
}

-(UIView*) contentViewForCell:(UIView*)cell forText:(NSString*) text forIndexPath:(NSIndexPath*) indexPath {
    
    UIView *view = [[UIView alloc] initWithFrame:cell.frame];
    [view setTag:indexPath.row];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, cell.frame.origin.y+10, 20, 20)];
    BOOL checkedValue = [[checkedArray objectAtIndex:indexPath.row] boolValue];
    imageView = [self imageViewForChecked:checkedValue];
    [imageView setFrame:CGRectMake(10, cell.frame.origin.y+10, 10, 10)];
    [view addSubview:imageView];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, cell.frame.origin.y, 200, 30)];
    [label setFont:[UIFont fontWithName:@"Arial" size:14]];
    [label setText:text];
    [view addSubview:label];

    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RDTrendObject *trendObject = [trendsArray objectAtIndex:indexPath.row];
    static NSString* cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier]; //iOS 5 function
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if ([trendObject selected]) {
        [checkedArray addObject:@"YES"];
    }else{
        [checkedArray addObject:@"NO"];
    }
    UIView *view = cell.contentView;
    for (UIView *views in [cell.contentView subviews]) {
        [views removeFromSuperview];
    }
    
    [cell.contentView addSubview:[self contentViewForCell:view forText:trendObject.name forIndexPath:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL checkedValue = [[checkedArray objectAtIndex:indexPath.row] boolValue];
    BOOL newCheckedValue= checkedValue?NO:YES;
    [checkedArray replaceObjectAtIndex:indexPath.row withObject:(newCheckedValue?@"YES":@"NO")];
    NSArray *idxPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self reloadRowsAtIndexPaths:idxPaths withRowAnimation:NO];
}

@end
