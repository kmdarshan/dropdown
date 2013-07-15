//
//  RDTrendsTableView.h
//  Trendster
//
//  Created by Darshan Katrumane on 5/9/13.
//  Copyright (c) 2013 trendster. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDTrendsTableView : UITableView <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *checkedArray;
}
@property (nonatomic, strong) NSMutableArray *checkedArray;
-(id) initWithTrends:(NSMutableArray*) trends;
@property (nonatomic, strong) NSMutableArray *trendsArray;
@end
