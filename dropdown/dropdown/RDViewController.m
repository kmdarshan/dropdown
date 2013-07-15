//
//  RDViewController.m
//  dropdown
//
//  Created by kmd on 7/15/13.
//  Copyright (c) 2013 RD. All rights reserved.
//

#import "RDViewController.h"
#import "RDTrendsTableView.h"
#import "RDTrendObject.h"

@interface RDViewController ()
{
    BOOL isTableOpened;
    RDTrendsTableView *trendTableView;
    UIButton *button;
}
@end

@implementation RDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    isTableOpened = NO;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        RDTrendObject *trendObject = [[RDTrendObject alloc] init];
        [trendObject setSelected:NO];
        [trendObject setName:[NSString stringWithFormat:@"index %d", i]];
        [arr addObject:trendObject];
    }
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.view addSubview:button];
    [button setFrame:CGRectMake(20, 20, 200, 40)];
    [button addTarget:self action:@selector(showTable) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"show table" forState:UIControlStateNormal];
    trendTableView = [[RDTrendsTableView alloc] initWithTrends:arr];
    [trendTableView setFrame:CGRectMake(0, 100, self.view.frame.size.width-40, 0)];
    [trendTableView setCenter:CGPointMake(self.view.center.x, trendTableView.center.y)];
    [self.view addSubview:trendTableView];
}

-(void) showTable {
    
    [UIView animateWithDuration:0.5f animations:^{
        if (isTableOpened) {
            isTableOpened = NO;
            [button setTitle:@"show table" forState:UIControlStateNormal];
            [trendTableView setFrame:CGRectMake(trendTableView.frame.origin.x, trendTableView.frame.origin.y, self.view.frame.size.width-40, 0)];
        }else{
            isTableOpened = YES;
            [button setTitle:@"hide table" forState:UIControlStateNormal];
            [trendTableView setFrame:CGRectMake(trendTableView.frame.origin.x, trendTableView.frame.origin.y, self.view.frame.size.width-40, 200)];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
